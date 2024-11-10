import 'package:roboti_app/presentation/chat/model/chat_model.dart';

class ChatHistoryModel {
  final List<ChatModel> chatList;
  const ChatHistoryModel({
    required this.chatList,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    List<ChatModel> chat = [];

    for (Map<String, dynamic> ele in json['model_responses']) {
      chat.add(ChatModel.fromHistory(ele));
    }

    return ChatHistoryModel(chatList: chat);
    // String type = json['type'] ?? "text";
    // String msg = type == "text" ? json['text'] : json['image_url']['url'];
    // return ChatHistoryModel(
    //   msg: msg,
    //   type: type,
    //   fromUser: json['fromUser'],
    // );
  }

  @override
  String toString() {
    return chatList.map((e) => e.toString()).toString();
  }

  bool search(String text) {
    // return chatList.forEach((element) {element.message.toLowerCase().contains(text)});
    bool val = false;
    for (ChatModel chat in chatList) {
      if (chat.message.toLowerCase().contains(text.toLowerCase())) {
        return true;
      }
    }
    return val;
  }

  static ChatHistoryModel? copy(ChatHistoryModel? data) {
    if (data == null) return null;

    return ChatHistoryModel(chatList: data.chatList);
  }
}
