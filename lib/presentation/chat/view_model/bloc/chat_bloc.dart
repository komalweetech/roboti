// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/event_handler.dart';
// import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
// import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';

ChatBloc chatBloc = ChatBloc();

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  TextEditingController? msgController;
  // final String chatModel = "gpt-4-vision-preview";
  final String chatModel = "gpt-4o";
  File? image;
  List<ChatModel> chat = [];

  ChatBloc() : super(ChatInitialState()) {
    on<ChatEvent>(ChatEventHandler().chatHandler);
}
}
