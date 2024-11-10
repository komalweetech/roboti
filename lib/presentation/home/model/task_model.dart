import 'package:roboti_app/utils/extensions/string_extendsions.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String translatedTitle;
  final String translatedDescription;
  final String prompt;
  final String sorting;
  // final String translatedPrompt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.translatedTitle,
    required this.translatedDescription,
    required this.prompt,
    required this.sorting,
    // required this.translatedPrompt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['name'].toString().capitalizeFirst(),
      description: json['descripiton'].toString().capitalizeFirst(),
      translatedTitle: json['translaName'].toString().capitalizeFirst(),
      translatedDescription:
          json['translaDescriptions'].toString().capitalizeFirst(),
      prompt: json['prompt'] ?? "",
      sorting: json['sorting'] ?? 'a',
      // translatedPrompt: json['translaPrompt'] ?? "",
    );
  }
}
