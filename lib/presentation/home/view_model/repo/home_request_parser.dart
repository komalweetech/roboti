import 'dart:convert';

import 'package:roboti_app/presentation/home/model/prompt_model.dart';

class HomeRequestParser {
  String getSendFCMTokenReqBody(String token) {
    Map<String, dynamic> reqBody = {"fcm_token": token};

    return jsonEncode(reqBody);
  }

  String getCategoriesReqBody({required int page, required int limit}) {
    Map<String, dynamic> requestBody = {"page": page, "limit": limit};

    return jsonEncode(requestBody);
  }

  String getTasksReqBody({
    required String categoryId,
    required int page,
    required int limit,
  }) {
    Map<String, dynamic> requestBody = {
      "categoryId": categoryId,
      "page": page,
      "limit": limit
    };

    return jsonEncode(requestBody);
  }

  String getFieldsReqBody({required String taskId}) {
    return jsonEncode({"taskId": taskId});
  }

  String getMessageReqBody({
    required List<Map<String, dynamic>> prompts,
  }) {
    final Map<String, dynamic> requestBody = {
      "model": "gpt-4o",
      // "model": "gpt-4-vision-preview",
      // "model": "gpt-3.5-turbo",
      "messages": prompts,
      "temperature": 0.6,
      "max_tokens": 1000,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0,
    };

    return jsonEncode(requestBody);
  }

  String getMessageVisionReqBody({
    required String imageUrl,
    required List<PromptModel> prompts,
  }) {
    final Map<String, dynamic> requestBody = {
      "model": "gpt-4o",
      // "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            // Setting the image
            {
              "type": "image_url",
              "image_url": {
                "url": imageUrl,
              }
            },

            // Setting the system URL and other user messages
            ...prompts
                .where((prompt) => prompt.isSystemPrompt || prompt.isUserPrompt)
                .map(
                  (prompt) => {
                    "type": "text",
                    "text": prompt.content,
                  },
                ),
          ],
        },
      ],
      "temperature": 0.6,
      "max_tokens": 1000,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0,
    };

    return jsonEncode(requestBody);
  }

  String getGoogleTranslationReqBody(String content, bool translateInEng) {
    String source = translateInEng ? "ar" : "en";
    String target = translateInEng ? "en" : "ar";
    final Map<String, dynamic> requestBody = {
      "q": content,
      "source": source,
      "target": target,
      "format": "text"
    };

    return jsonEncode(requestBody);
  }
}
