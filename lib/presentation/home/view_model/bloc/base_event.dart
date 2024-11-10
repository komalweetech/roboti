import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roboti_app/presentation/home/model/category_model.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/model/task_model.dart';

abstract class HomeEvent {}

abstract class CategoriesEvent extends HomeEvent {}

class GetCategoriesEvent extends CategoriesEvent {}

class SelectCategoryEvent extends CategoriesEvent {
  final BuildContext context;
  final HomeCategoryModel category;

  SelectCategoryEvent({required this.context, required this.category});
}

abstract class TaskEvent extends HomeEvent {}

class GetTasksEvent extends TaskEvent {}

class SelectTaskEvent extends TaskEvent {
  final BuildContext context;
  final TaskModel task;

  SelectTaskEvent({required this.context, required this.task});
}

abstract class FieldEvent extends HomeEvent {}

class GetFieldsEvent extends FieldEvent {}

class DisposeFieldsControllersEvent extends FieldEvent {}

class EditingFormFieldEvent extends FieldEvent {
  final bool validationErrorHasOccured;

  EditingFormFieldEvent({required this.validationErrorHasOccured});
}

abstract class FieldChatEvent extends HomeEvent {}

class GetEditTaskForHistoryEvent extends FieldChatEvent {}

class GetChatCompletionEvent extends FieldChatEvent {}

class ChatCompletionLoadingEvent extends FieldChatEvent {}

class StopChatCompletionLoadingEvent extends FieldChatEvent {}

class SummarizeChatCompletionLoadingEvent extends FieldChatEvent {
  bool isTranslated;

  SummarizeChatCompletionLoadingEvent({required this.isTranslated});
}

class StopSummarizeChatCompletionLoadingEvent extends FieldChatEvent {}

class SummarizeChatCompletionEvent extends FieldChatEvent {
  String content;
  bool isTranslated;

  SummarizeChatCompletionEvent({
    required this.content,
    required this.isTranslated,
  });
}

class TranslateGptResponseEvent extends FieldChatEvent {
  PromptModel prompt;
  bool translateInEng;

  TranslateGptResponseEvent({
    required this.prompt,
    required this.translateInEng,
  });
}

class RegenerateChatCompletionEvent extends FieldChatEvent {
  final bool fromHistory;

  RegenerateChatCompletionEvent({this.fromHistory = false});
}

class RegenerateChatCompletionLoadingEvent extends FieldChatEvent {}

class RegenerateChatCompletionCloseLoadingEvent extends FieldChatEvent {}

class SelectFieldChatImageEvent extends FieldChatEvent {
  XFile file;
  SelectFieldChatImageEvent({required this.file});
}

class RefreshAppLanguageEvent extends HomeEvent {}

class ChangeLanguageEvent extends HomeEvent {
  String val;
  BuildContext context;

  ChangeLanguageEvent({required this.val, required this.context});
}

class ProfileImageChangedEvent extends HomeEvent {}

class UpdateHistoryWithoutStateEvent extends HomeEvent {}

class GetCompletionFromHistoryEvent extends HomeEvent {
  final String id;
  GetCompletionFromHistoryEvent({required this.id});
}

//Event

class GetFCMTokenEvent extends HomeEvent {}

class ForceUpdateEvent extends HomeEvent {}
