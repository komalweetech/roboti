// import 'dart:convert';

import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';

class ChatRequestParser {
  Map<String, dynamic> chatReqBody(List<ChatModel> chat, String chatModel) {
    List<String> images = [];
    List<String> text = [];

    // Separating the text and images for generating the json
    for (ChatModel chat in chat) {
      if (chat.type == ChatType.img) {
        text.add(chat.animatedMessages);
        images.add(chat.imageUrl!);
      } else {
        text.add(chat.message);
      }
    }

    // Creating the vision of (GPT-4.0) json request body
    Map<String, dynamic> requestBody = {
      "model": chatModel,
      "messages": [
        {
          "role": "user",
          "content": [
            ...images.map(
              (imageYrl) => {
                "type": "image_url",
                "image_url": {"url": imageYrl}
              },
            ),
            ...text.map(
              (msg) => {"type": "text", "text": msg},
            ),
          ],
        },
      ],
      "temperature": 0.9,
      "max_tokens": 1000,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0,
    };
    LogManager.log(head: 'CHAT IMAGE', msg: 'request to gpt \n $requestBody');
    return requestBody;
  }
}
