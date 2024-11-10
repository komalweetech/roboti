import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_events.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_states.dart';
import 'package:roboti_app/presentation/history/view_model/repo/history_repo.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';

class HistoryHandler {
  final HistoryRepo _historyRepo = HistoryRepo();
  FutureOr<void> historyHandler(
    HistoryEvents event,
    Emitter<HistoryStates> emit,
  ) async {
    if (event is GetAllHistoryEvent) {
      await _getAllHistoryEventHandler(event, emit);
    } else if (event is GetHistoryByIdEvent) {
      await _getHistoryByIdEvent(event, emit);
    } else if (event is CreateChatHistoryEvent) {
      await _createChatHistoryEvent(event, emit);
    } else if (event is GetPaginatedHistoryEvent) {
      await _getAllHistoryEventHandler(event, emit);
    } else if (event is UpdateHistoryEvent) {
      await _updateHistory(event, emit);
    }
  }

  Future<void> _getAllHistoryEventHandler(
    HistoryEvents event,
    Emitter<HistoryStates> emit,
  ) async {
    int limit = 10;

    // Pagination Implemented
    if (event is GetPaginatedHistoryEvent) {
      limit = historyBloc.history.length + 10;
    }

    // Pagination Loader
    if (event is GetPaginatedHistoryEvent) {
      emit(GetAllHistoryPaginationLoadingState());
    } else {
      emit(GetAllHistoryLoadingState());
    }

    List<HistoryModel>? response = [];
    Map<String, List<HistoryModel>> dates = {};
    (response, dates) = await _historyRepo.getAllHistory(limit);

    if (response == null) {
      return emit(GetAllHistoryErrorState());
    }

    // for (HistoryModel history in response) {
    //   log('[HISTORY DATA] ${history.toString()}');
    // }

    historyBloc.history = response;
    historyBloc.dates = dates;
    return emit(GetAllHistorySuccessState());
  }

  Future<void> _getHistoryByIdEvent(
    GetHistoryByIdEvent event,
    Emitter<HistoryStates> emit,
  ) async {
    if (historyBloc.selectedHistory == null) {
      return emit(GetHistoryByIdErrorState());
    }

    String id = historyBloc.selectedHistory!.id;
    if (historyBloc.selectedHistory!.isCompletion) {
      homeBloc.add(GetCompletionFromHistoryEvent(id: id));
    } else {
      chatBloc.add(GetChatFromHistoryEvent(id: id));
    }
  }

  Future<void> _updateHistory(
    UpdateHistoryEvent event,
    Emitter<HistoryStates> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    emit(UpdateHistoryLoadingState());

    await HistoryRepo().updateHistory();

    emit(UpdateHistorySuccessState());
  }

  Future<void> _createChatHistoryEvent(
    CreateChatHistoryEvent event,
    Emitter<HistoryStates> emit,
  ) async {
    if (chatBloc.chat.isNotEmpty) {
      await _historyRepo.createChatHistory();
    }
  }
}
