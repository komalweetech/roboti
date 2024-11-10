import 'package:roboti_app/presentation/history/model/history_model.dart';

extension SearchDataFor on List<HistoryModel> {
  List<HistoryModel> searchData(String value) {
    List<HistoryModel> data = where((data) {
      bool searched = false;
      if (data.isCompletion) {
        searched = data.completionHistory!.search(value);
      } else {
        searched = data.chatHistory!.search(value);
      }
      return searched;
    }).toList();
    return data;
  }
}
