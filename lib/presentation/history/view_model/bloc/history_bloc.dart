import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc_handler.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_events.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_states.dart';

HistoryBloc historyBloc = HistoryBloc(
  historyId: "",
  history: [],
  dates: {},
  selectedHistory: null,
);

class HistoryBloc extends Bloc<HistoryEvents, HistoryStates> {
  String historyId;
  List<HistoryModel> history;
  Map<String, List<HistoryModel>> dates;
  HistoryModel? selectedHistory;
  HistoryBloc({
    required this.historyId,
    required this.history,
    required this.dates,
    required this.selectedHistory,
  }) : super(HistoryInitialState()) {
    on<HistoryEvents>(HistoryHandler().historyHandler);
  }

  void resetValues() {
    history.clear();
    dates.clear();
    selectedHistory = null;
    historyId = "";
  }
}
