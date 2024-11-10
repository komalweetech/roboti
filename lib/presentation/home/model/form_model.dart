import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';

class FormModel {
  final bool isImage;
  final bool isImageOptional;
  final bool isTone;
  final bool isLength;
  final String formId;
  final List<FieldModel> fields;
  List<PromptModel> prompts;
  final String basePrompt;
  final String toneName, lengthName;

  FormModel({
    required this.fields,
    required this.formId,
    required this.isImage,
    required this.isImageOptional,
    required this.isLength,
    required this.isTone,
    required this.prompts,
    required this.basePrompt,
    this.lengthName = "[LENGTH]",
    this.toneName = "[TONE]",
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    List<FieldModel> formFields = [];

    for (Map<String, dynamic> field in json['field']) {
      formFields.add(FieldModel.fromJson(field));
    }

    int tempOrder = formFields.length + 1;

    for (var field in formFields) {
      if (field.order == null) {
        field.order = tempOrder;
        tempOrder++;
      }
    }

    formFields.sort((a, b) => a.order!.compareTo(b.order!));

    return FormModel(
      fields: formFields,
      formId: json['_id'],
      isImage: json['image'] ?? false,
      isImageOptional: json['imageOptional'] ?? false,
      isLength: json['length'] ?? false,
      isTone: json['tone'] ?? false,
      basePrompt: json['prompt'],
      prompts: [],
      toneName: "[TONE]",
      lengthName: "[LENGTH]",
    );
  }

  List<Map<String, dynamic>> getPromptsJson() {
    return prompts.map((prompt) => prompt.toJson()).toList();
  }

  factory FormModel.onlyPrompts(List<PromptModel> prompts) {
    return FormModel(
      fields: [],
      formId: "",
      isImage: false,
      isImageOptional: false,
      isLength: false,
      isTone: false,
      prompts: prompts,
      basePrompt: "",
    );
  }
}
