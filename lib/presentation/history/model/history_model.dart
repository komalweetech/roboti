import 'package:roboti_app/presentation/history/model/hist_chat_model.dart';
import 'package:roboti_app/presentation/history/model/hist_completion_model.dart';
import 'package:roboti_app/presentation/history/model/history_data_parser_class.dart';
import 'package:roboti_app/presentation/history/view_model/enums/history_type.dart';

class HistoryModel {
  final String id;
  final DateTime createDate;
  final CompletionHistoryModel? completionHistory;
  final ChatHistoryModel? chatHistory;
  final HistoryType type;

  const HistoryModel({
    required this.id,
    required this.createDate,
    required this.completionHistory,
    required this.chatHistory,
    required this.type,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    HistoryType type = HistoryDataParser.getType(json['completion'].isNotEmpty);
    DateTime createDate = DateTime.parse(json['createdAt']);
    String id = json['_id'];

    CompletionHistoryModel? completion;
    ChatHistoryModel? chat;

    if (type == HistoryType.completion) {
      completion = CompletionHistoryModel.fromJson(json['completion']);
    } else {
      chat = ChatHistoryModel.fromJson(json['chat']);
    }

    return HistoryModel(
      id: id,
      createDate: createDate,
      completionHistory: completion,
      chatHistory: chat,
      type: type,
    );
  }

  bool get isCompletion => type == HistoryType.completion;
  bool get isChat => type == HistoryType.chat;

  factory HistoryModel.copy(HistoryModel history) {
    return HistoryModel(
      id: history.id,
      createDate: history.createDate,
      completionHistory: CompletionHistoryModel.copy(history.completionHistory),
      chatHistory: ChatHistoryModel.copy(history.chatHistory),
      type: history.type,
    );
  }

  @override
  String toString() {
    return "id: $id, createDate: $createDate, type: $type, completionHistory: ${completionHistory?.toString() ?? ""}, chatHistory: ${chatHistory?.toString() ?? ""}";
  }
}
