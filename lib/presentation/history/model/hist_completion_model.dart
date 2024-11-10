import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/history/model/history_data_parser_class.dart';
import 'package:roboti_app/presentation/history/model/history_field_info_model.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';

class CompletionHistoryModel {
  final String taskId, taskName, taskTranslatedName;
  final String catId, catName, catTranslatedName;
  final String formId;
  final String tone, length, imageUrl, prompt;
  final List<FieldInfo> fieldInfo;
  final List<CompletionResponseModel> modelResponses;

  const CompletionHistoryModel({
    required this.catId,
    required this.catName,
    required this.catTranslatedName,
    required this.taskId,
    required this.taskName,
    required this.taskTranslatedName,
    required this.formId,
    required this.tone,
    required this.length,
    required this.imageUrl,
    required this.prompt,
    required this.fieldInfo,
    required this.modelResponses,
  });

  factory CompletionHistoryModel.fromJson(Map<String, dynamic> json) {
    String taskId = json['task_info'].isEmpty ? "" : json['task_info']['id'];
    String taskName =
        json['task_info'].isEmpty ? "" : json['task_info']['title'];
    String taskTranslatedName =
        json['task_info'].isEmpty ? "" : json['task_info']['translatedName'];
    String catId =
        json['category_info'].isEmpty ? "" : json['category_info']['id'];
    String catName =
        json['category_info'].isEmpty ? "" : json['category_info']['title'];
    String catTranslatedName = json['category_info'].isEmpty
        ? ""
        : json['category_info']['translatedName'];
    String formId = json['form_info']['form_id'];
    String tone = json['form_info']['tone'] ?? "";
    String length = json['form_info']['length'] ?? "";
    String imageUrl = json['form_info']['image_url'] ?? "";
    String prompt = json['form_info']['prompt'] ?? "";
    List<FieldInfo> fieldInfo = HistoryDataParser.getFieldsInfo(
        json['form_info']?['fields_info'] ?? []);
    List<CompletionResponseModel> modelResponses =
        HistoryDataParser.getCompletionModelResponses(
            json['model_responses'] ?? []);

    return CompletionHistoryModel(
      catId: catId,
      catName: catName,
      catTranslatedName: catTranslatedName,
      taskId: taskId,
      taskName: taskName,
      taskTranslatedName: taskTranslatedName,
      formId: formId,
      tone: tone,
      length: length,
      imageUrl: imageUrl,
      prompt: prompt,
      fieldInfo: fieldInfo,
      modelResponses: modelResponses,
    );
  }

  CompletionResponseModel get firstGPTResponseModel =>
      modelResponses.firstWhere((response) => response.isAssitantPrompt);

  bool search(String text) {
    // return (isEng
    //         ? modelResponses.first.content
    //         : modelResponses.first.translation)
    //     .toLowerCase()
    //     .contains(text);
    return (isEng ? catName : catTranslatedName)
            .toLowerCase()
            .contains(text.toLowerCase()) ||
        (isEng ? taskName : taskTranslatedName)
            .toLowerCase()
            .contains(text.toLowerCase()) ||
        (isEng
                ? modelResponses.first.content
                : modelResponses.first.translation)
            .toLowerCase()
            .contains(text);
    // String catText = text.toLowerCase();
    // return catName.toLowerCase().contains(catText) ||
    //     catTranslatedName.toLowerCase().contains(catText) ||
    //     taskName.toLowerCase().contains(catText) ||
    //     taskTranslatedName.toLowerCase().contains(catText) ||
    //     firstGPTResponseModel.content.toLowerCase().contains(catText) ||
    //     firstGPTResponseModel.translation.toLowerCase().contains(catText);
  }

  static CompletionHistoryModel? copy(CompletionHistoryModel? data) {
    if (data == null) return null;
    return CompletionHistoryModel(
      catId: data.catId,
      catName: data.catName,
      catTranslatedName: data.catTranslatedName,
      taskId: data.taskId,
      taskName: data.taskName,
      taskTranslatedName: data.taskTranslatedName,
      formId: data.formId,
      tone: data.tone,
      length: data.length,
      imageUrl: data.imageUrl,
      prompt: data.prompt,
      fieldInfo: List.from(data.fieldInfo),
      modelResponses: List.from(data.modelResponses),
    );
  }

  List<PromptModel> responsesToPromptsList() {
    List<PromptModel> prompts = [];

    prompts = modelResponses.map((res) => res.toPromptModel()).toList();

    return prompts;
  }

  @override
  String toString() {
    return "taskId: $taskId, taskName: $taskName, taskTranslatedName; $taskTranslatedName, catId: $catId, catName: $catName, catTranslatedName, $catTranslatedName, formId: $formId, tone: $tone, length: $length, imageUrl: $imageUrl, prompt: $prompt, fieldInfo: ${fieldInfo.map((e) => e.toString()).toString()}, modelResponses: ${modelResponses.map((e) => e.toString()).toString()}";
  }
}

class CompletionResponseModel {
  final String role, content, translation;
  final int rating;
  final bool isEng;

  const CompletionResponseModel({
    required this.role,
    required this.content,
    required this.translation,
    required this.rating,
    required this.isEng,
  });

  factory CompletionResponseModel.fromJson(dynamic json) {
    return CompletionResponseModel(
      role: json['role'],
      content: json['content'],
      translation: json['translation'],
      rating: json['rating'],
      isEng: json['isEng'] ?? true,
    );
  }

  PromptModel toPromptModel() {
    return PromptModel.fromHistoryJson(this);
  }

  bool get isAssitantPrompt => role.toLowerCase() == "assistant";

  @override
  String toString() {
    return "role, $role, content: $content, translation: $translation, rating: $rating, isEng: $isEng";
  }
}
