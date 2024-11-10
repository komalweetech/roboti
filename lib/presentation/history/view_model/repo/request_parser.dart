import 'dart:convert';

import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/enums/history_type.dart';
import 'package:roboti_app/presentation/home/model/category_model.dart';
import 'package:roboti_app/presentation/home/model/form_model.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/model/task_model.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';

class HistoryRequestParser {
  String getAllHistoryRequest({int page = 1, int limit = 10}) {
    Map<String, dynamic> requestBody = {
      "limit": limit,
      "page": page,
      "search": ""
    };

    return jsonEncode(requestBody);
  }

  String getAllHistory({int limit = 10, int page = 1}) {
    return jsonEncode({"limit": limit, "page": page, "search": ""});
  }

  String createHistoty({
    required HomeCategoryModel category,
    required TaskModel task,
    required FormModel form,
    required String imageUrl,
    required String tone,
    required String length,
  }) {
    List<Map<String, dynamic>> fields = form.fields
        .map(
          (field) => {
            "field_id": field.id,
            "user_input": field.isDropdown
                ? isEng
                    ? homeBloc.selectedOptions![field.id]?.text ?? ""
                    : homeBloc.selectedOptions![field.id]?.arabicText ?? ""
                : field.textController!.text,
          },
        )
        .toList();
    Map<String, dynamic> requestBody = {
      "completion": {
        "type": HistoryType.completion.name,
        "category_info": {
          "id": category.id,
          "title": category.title,
          "translatedName": category.translatedTitle,
        },
        "task_info": {
          "id": task.id,
          "title": task.title,
          "translatedName": task.translatedTitle,
        },
        "form_info": {
          "form_id": form.formId,
          "tone": tone,
          "image_url": imageUrl,
          "length": length,
          "prompt": form.prompts.first.content,
          "fields_info": fields,
        },
        "model_responses": [form.prompts.last.toHistoryJson(isEng)],
      },
    };

    return jsonEncode(requestBody);
  }

  String createChatHistoty() {
    Map<String, dynamic> requestBody = {
      "chat": {
        "type": HistoryType.chat.name,
        "model_responses":
            chatBloc.chat.map((chat) => chat.toHistoryJson()).toList(),
      },
    };

    return jsonEncode(requestBody);
  }

  String updateHistory({required FormModel form}) {
    List<Map<String, dynamic>> prompts = [];
    for (PromptModel prompt in form.prompts) {
      prompts.add(prompt.toHistoryJson(prompt.isInEng));
    }
    // Map<String, dynamic> requestBody = {"model_responses": prompts};
    List<Map<String, dynamic>> fields =
        historyBloc.selectedHistory!.completionHistory!.fieldInfo
            .map(
              (field) => {"field_id": field.id, "user_input": field.input},
            )
            .toList();
    Map<String, dynamic> requestBody = {
      "completion": {
        "type": HistoryType.completion.name,
        "category_info": {
          "id": historyBloc.selectedHistory!.completionHistory!.catId,
          "title": historyBloc.selectedHistory!.completionHistory!.catName,
          "translatedName":
              historyBloc.selectedHistory!.completionHistory!.catTranslatedName,
        },
        "task_info": {
          "id": historyBloc.selectedHistory!.completionHistory!.taskId,
          "title": historyBloc.selectedHistory!.completionHistory!.taskName,
          "translatedName": historyBloc
              .selectedHistory!.completionHistory!.taskTranslatedName,
        },
        "form_info": {
          "form_id": historyBloc.selectedHistory!.completionHistory!.formId,
          "tone": historyBloc.selectedHistory!.completionHistory!.tone,
          "image_url": historyBloc.selectedHistory!.completionHistory!.imageUrl,
          "length": historyBloc.selectedHistory!.completionHistory!.length,
          "prompt": historyBloc.selectedHistory!.completionHistory!.prompt,
          "fields_info": fields,
        },
        "model_responses": prompts,
      },
    };
    return jsonEncode(requestBody);
  }

  String updateChatHistory() {
    List<Map<String, dynamic>> chats = [];
    for (ChatModel prompt in chatBloc.chat) {
      chats.add(prompt.toHistoryJson());
    }
    Map<String, dynamic> requestBody = {
      "chat": {"type": HistoryType.chat.name, "model_responses": chats},
    };
    return jsonEncode(requestBody);
  }
}
