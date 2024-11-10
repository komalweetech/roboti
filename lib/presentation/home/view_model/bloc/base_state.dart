import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

// Category Api Call State
abstract class CategoryState extends HomeState {}

class HomeDataLoadingState extends CategoryState {}

class HomeDataErrorState extends CategoryState {}

class HomeDataSuccessState extends CategoryState {}

// Category Selection State
class SelectCategorySuccessState extends CategoryState {}

abstract class TaskState extends HomeState {}

// Task Api Call State
class TaskDataLoadingState extends TaskState {}

class TaskDataErrorState extends TaskState {}

class TaskDataSuccessState extends TaskState {}

// Task Selection State
class SelectTaskSuccessState extends TaskState {}

abstract class FieldsState extends HomeState {}

// Field Api Call State
class FieldsDataLoadingState extends FieldsState {}

class FieldsDataErrorState extends FieldsState {}

class FieldsDataSuccessState extends FieldsState {}

// Chat Completion Api Call States
abstract class ChatCompletionSate extends HomeState {}

class ChatCompletionLoadingState extends ChatCompletionSate with LoaderState {}

class ImageSelectionSuccessState extends ChatCompletionSate {}

class ChatCompletionInitialState extends ChatCompletionSate {}

class ChatCompletionErrorState extends ChatCompletionSate {}

class ChatCompletionSuccessState extends ChatCompletionSate {}

abstract class ChatRegenerationSate extends ChatCompletionSate {}

class ChatRegenerationInitialState extends ChatRegenerationSate {}

class ChatRegenerationLoadingState extends ChatRegenerationSate
    with LoaderState {}

class ChatRegenerationErrorState extends ChatRegenerationSate {}

class ChatRegenerationSuccessState extends ChatRegenerationSate {}

abstract class ChatSummarySate extends ChatCompletionSate {}

class ChatSummarizationLoadingState extends ChatSummarySate {
  final bool isTranslated;

  ChatSummarizationLoadingState({required this.isTranslated});
}

class ChatSummarizationErrorState extends ChatSummarySate {
  String message;
  ChatSummarizationErrorState({required this.message});
}

class ChatSummarizationSuccessState extends ChatSummarySate {
  PromptModel response;

  ChatSummarizationSuccessState({required this.response});
}

class ChatSummarizeInitialState extends ChatSummarySate {}

class LanguageChangedState extends ChatCompletionSate {}

class RequiredFormState extends ChatCompletionSate {}

class EditingTheFormState extends ChatCompletionSate {}

class FormFieldValidationErrorState extends ChatCompletionSate {}

class TranslateGptResponseLoadingState extends ChatCompletionSate {}

class TranslateGptResponseErrorState extends ChatCompletionSate {}

abstract class CompletionTranslationSuccessState extends ChatCompletionSate {}

class TranslateGptResponseSuccessState
    extends CompletionTranslationSuccessState {}

class TranslateFromCacheSuccessState
    extends CompletionTranslationSuccessState {}

class ProfileImageSelectedState extends HomeInitialState {}

class UpdateHistorySuccessState extends HomeState {}

// States
class FcmTokenFetchSuccessState extends HomeState {
  String token;

  FcmTokenFetchSuccessState({required this.token});
}

class FcmTokenFetchErrorState extends HomeState {}

class ForceUpdateRequiredState extends HomeState {}
