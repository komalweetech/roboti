import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/history/model/hist_completion_model.dart';

class PromptModel {
  final PromptRole role;
  final String content;
  String animatedMessages;
  String translatedContent;
  bool animated = false;
  Timer? timer;
  bool isTranslated = false;
  bool isTranslatingTapped = false;
  int ratings = 0;
  final bool isInEng;

  PromptModel({
    required this.content,
    required this.role,
    this.translatedContent = "",
    this.animated = false,
    this.timer,
    this.animatedMessages = "",
    this.isTranslated = false,
    this.isTranslatingTapped = false,
    this.ratings = 0,
    required this.isInEng,
  });

  factory PromptModel.fromJson(Map<String, dynamic> json) {
    PromptRole role = _getUserPromptRole(json['role']);

    // final content= new String.fromCharCodes(json['content']).trim();
    // final content = utf8.encode(json['content']);
    //  final decodedContent = utf8.decode(content);
    // final decodedText = latin1.decode(content);
    // print(decodedText);

    Map<String, dynamic> content = {};

    try {
      Response response = Response(jsonEncode(json), 200);

      final val = utf8.decode(response.bodyBytes);

      content = jsonDecode(val);
    } catch (e) {
      content = json;
    }

    return PromptModel(
      content: content['content'],
      role: role,
      isInEng: isEng,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role": role.name,
      "content": content,
    };
  }

  factory PromptModel.fromHistoryJson(CompletionResponseModel data) {
    return PromptModel(
      content: data.content,
      animated: true,
      role: _getUserPromptRole(data.role),
      translatedContent: data.translation,
      ratings: data.rating,
      isInEng: data.isEng,
    );
  }

  Map<String, dynamic> toHistoryJson(bool isEng) {
    return {
      "role": role.name,
      "content": content,
      "translation": translatedContent,
      "rating": ratings,
      "isEng": isEng,
    };
  }

  static PromptRole _getUserPromptRole(String role) {
    switch (role.toLowerCase()) {
      case "system":
        return PromptRole.system;
      case "user":
        return PromptRole.user;

      default:
        return PromptRole.assistant;
    }
  }

  void toggleTranslation() {
    isTranslated = !isTranslated;
  }

  bool get isSystemPrompt => role == PromptRole.system;
  bool get isUserPrompt => role == PromptRole.user;
  bool get isAssistantPrompt => role == PromptRole.assistant;

  bool get allowSummarization => (content).split(" ").length >= 40;
}

enum PromptRole { system, user, assistant }
