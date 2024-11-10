import 'dart:async';

class ChatModel {
  final String message;
  String animatedMessages;
  final bool fromUser;
  final ChatType type;
  Timer? timer;
  final String? imageUrl;
  final bool animateMessage;

  ChatModel({
    required this.fromUser,
    required this.message,
    this.animatedMessages = "",
    required this.type,
    this.timer,
    this.imageUrl,
    this.animateMessage = true,
  });

  Map<String, dynamic> toHistoryJson() {
    if (type == ChatType.text) {
      return {
        "type": "text",
        "text": message,
        "fromUser": fromUser,
      };
    } else {
      return {
        "type": "image_url",
        "fromUser": fromUser,
        "image_url": {"url": imageUrl},
        "text": animatedMessages,
      };
    }
  }

  factory ChatModel.fromHistory(Map<String, dynamic> history) {
    ChatType type = _getType(history['type']);
    // String msg =
    //     type == ChatType.text ? history['text'] : history['image_url']['url'];
    // bool fromUser = history['fromUser'] ?? false;

    // return ChatModel(
    //   fromUser: fromUser,
    //   message: msg,
    //   type: type,
    //   animateMessage: false,
    // );
    if (type == ChatType.text) {
      return ChatModel(
        fromUser: history['fromUser'] ?? false,
        message: history['text'],
        type: type,
        animateMessage: false,
      );
    } else {
      return ChatModel(
        fromUser: history['fromUser'] ?? false,
        message: history['text'] ?? "",
        animatedMessages: history['text'] ?? "",
        type: type,
        animateMessage: false,
        imageUrl: history['image_url']?['url'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (type == ChatType.text) {
      return {
        "type": "text",
        "text": message,
      };
    } else {
      return {
        "type": "image_url",
        "image_url": {
          "url": message,
        }
      };
    }
  }

  static ChatType _getType(String type) {
    switch (type.toLowerCase()) {
      case "text":
        return ChatType.text;
      default:
        return ChatType.img;
    }
  }

  @override
  String toString() {
    return "message: $message, animatedMessages: $animatedMessages, fromUser: $fromUser, type: $type, imageUrl $imageUrl";
  }
}

enum ChatType { text, img }
