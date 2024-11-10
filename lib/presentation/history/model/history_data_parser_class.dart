import 'package:roboti_app/presentation/history/model/hist_completion_model.dart';
import 'package:roboti_app/presentation/history/model/history_field_info_model.dart';
import 'package:roboti_app/presentation/history/view_model/enums/history_type.dart';

class HistoryDataParser {
  static List<FieldInfo> getFieldsInfo(List<dynamic> json) {
    List<FieldInfo> info = [];

    for (dynamic data in json) {
      info.add(FieldInfo.fromJson(data));
    }

    return info;
  }

  static List<CompletionResponseModel> getCompletionModelResponses(
    List<dynamic> json,
  ) {
    List<CompletionResponseModel> responses = [];

    for (dynamic ele in json) {
      responses.add(CompletionResponseModel.fromJson(ele));
    }

    return responses;
  }

  static HistoryType getType(bool isCompletion) {
    return isCompletion ? HistoryType.completion : HistoryType.chat;
    // switch (type.toLowerCase()) {
    //   case "chat":
    //     return HistoryType.chat;
    //   default:
    //     return HistoryType.completion;
    // }
  }
}
