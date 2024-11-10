// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/presentation/chat/ui/screen/chat_screen.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/chat/view_model/repo/chat_repo.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/repo/history_repo.dart';
// import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
// import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';

class ChatEventHandler {
  ChatRepo chatRepo = ChatRepo();
  FutureOr<void> chatHandler(
    ChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (event is ResetChatDataEvent) {
      _onResetChatEvent(event, emit);
    } else if (event is SendMessageEvent) {
      await _onSendMessageEvent(event, emit);
    } else if (event is ResponseAnimationCompletedEvent) {
      emit(MessageResponseSuccessState());
    } else if (event is StopAnimatingGPTResponseEvent) {
      emit(MessageResponseAnimationPauseState());
    } else if (event is AddChatImageEvent) {
      await _onChatImageAddEvent(event, emit);
    } else if (event is UnselectChatImageEvent) {
      chatBloc.image = null;
      chatBloc.msgController!.clear();
      emit(ChatImageUnselectedState());
    } else if (event is GetChatFromHistoryEvent) {
      await _getChatFromHistoryEvent(event, emit);
    } else if (event is UpdateChatFromHistoryEvent) {
      await _updateChatFromHistoryEvent(event, emit);
    } else if (event is ShowLoaderToButtonEvent) {
      await _showLoaderToButtonEvent(event, emit);
    } else if (event is ResetChatStatesEvent) {
      emit(ChatInitialState());
    }
  }

  Future<void> _showLoaderToButtonEvent(
    ShowLoaderToButtonEvent event,
    Emitter<ChatState> emit,
  ) async {
    chatBloc.msgController!.text;
    String message = chatBloc.msgController!.text.trim();

    if (message.isEmpty) {
      ErrorMessages.display(lcGlobal.emptyMessageError);
      return emit(MessageSentErrorState());
    }
    return emit(MessageResponseLoadingState());
  }

  Future<void> _updateChatFromHistoryEvent(
    UpdateChatFromHistoryEvent event,
    Emitter<ChatState> emit,
  ) async {
    await HistoryRepo().updateChatHistory();
  }

  Future<void> _getChatFromHistoryEvent(
    GetChatFromHistoryEvent event,
    Emitter<ChatState> emit,
  ) async {
    CustomCupertinoLoader.showLoaderDialog();
    HistoryModel? response =
        await HistoryRepo().getHistoryById(id: historyBloc.selectedHistory!.id);
    CustomCupertinoLoader.dispose();
    if (response == null) {
      ErrorMessages.display(lcGlobal.unableToGetHistory);
    } else {
      // Setting selected category
      chatBloc.chat =
          List.from(historyBloc.selectedHistory!.chatHistory!.chatList);

      // Routing to Chat Screen
      Widget route = const ChatScreen(fromHistory: true);
      GlobalContext.currentContext!.pushRoute(route);
    }
  }

  Future<void> _onChatImageAddEvent(
    AddChatImageEvent event,
    Emitter<ChatState> emit,
  ) async {
    chatBloc.image = File(event.file.path);
    emit(ChatImageSelectedState());
  }

  void _onResetChatEvent(
    ResetChatDataEvent event,
    Emitter<ChatState> emit,
  ) {
    chatBloc.chat.clear();
    chatBloc.image = null;
    emit(ChatInitialState());
  }

  Future<void> _onSendMessageEvent(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    chatBloc.msgController!.text;
    String message = chatBloc.msgController!.text.trim();

    if (message.isEmpty) return emit(MessageSentErrorState());

    if (chatBloc.image != null) {
      // Image selected
      emit(MessageResponseLoadingState());

      Map<String, dynamic> response =
          await NetworkApiService().multipartApiCall(chatBloc.image!);
      if (response.containsKey("image_url")) {
        chatBloc.msgController!.clear();

        LogManager.log(head: 'CHAT IMAGE', msg: '${response['image_url']}');

        chatBloc.chat.add(
          ChatModel(
            fromUser: true,
            message: chatBloc.image!.path,
            animatedMessages: message,
            type: ChatType.img,
            imageUrl: response['image_url'],
          ),
        );
      } else {
        ErrorMessages.display(response['message']);
        return emit(MessageSentErrorState());
      }
    } else {
      chatBloc.msgController!.clear();

      chatBloc.chat.add(
        ChatModel(fromUser: true, message: message, type: ChatType.text),
      );
    }
    chatBloc.image = null;

    emit(MessageSentSuccessState());

    await _fetchResponse(emit);
  }

  Future<void> _fetchResponse(Emitter<ChatState> emit) async {
    emit(MessageResponseLoadingState());
    Map<String, dynamic> response = await chatRepo.sendMessage();
    if (response.containsKey("error")) {
      ErrorMessages.display(response['error']['message']);
      emit(MessageResponseErrorState());
    } else {
      Map<String, dynamic> content = decodeMessage(response);
      String message = content['choices'][0]['message']['content'];
      chatBloc.chat.add(
        ChatModel(fromUser: false, message: message, type: ChatType.text),
      );
      emit(MessageResponseAnimatingState());
    }
  }

  Map<String, dynamic> decodeMessage(Map<String, dynamic> response) {
    Map<String, dynamic> content = {};

    try {
      Response chat = Response(jsonEncode(response), 200);

      final val = utf8.decode(chat.bodyBytes);

      content = jsonDecode(val);
    } catch (e) {
      return response;
    }

    return content;
  }
}
