// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/history/model/hist_completion_model.dart';
import 'package:roboti_app/presentation/history/model/history_field_info_model.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/repo/history_repo.dart';
import 'package:roboti_app/presentation/home/model/category_model.dart';
import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/model/field_options.dart';
import 'package:roboti_app/presentation/home/model/form_model.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/model/task_model.dart';
import 'package:roboti_app/presentation/home/ui/screen/chat_response_screen.dart';
import 'package:roboti_app/presentation/home/ui/screen/fields_screen.dart';
import 'package:roboti_app/presentation/home/ui/screen/task_screen.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/home/view_model/common/force_update_popup.dart';
import 'package:roboti_app/presentation/home/view_model/common/home_vm.dart';
import 'package:roboti_app/presentation/home/view_model/repo/home_repo.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';
import 'package:roboti_app/utils/shared_pref_manager/pref_keys.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

class HomeEventsHandler {
  final HomeRepo homeRepo = HomeRepo();
  final HomeVMHelper homeVMHelper = HomeVMHelper();
  FutureOr<void> homeHandler(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event is ForceUpdateEvent) {
      await _checkForForceUpdate(event, emit);
    } else if (event is GetCategoriesEvent) {
      await _getAllCategories(event, emit);
    } else if (event is SelectCategoryEvent) {
      _setSelectedCategory(event, emit);
    } else if (event is GetTasksEvent) {
      await _getAllTasks(event, emit);
    } else if (event is SelectTaskEvent) {
      _setSelectedTask(event, emit);
    } else if (event is GetFieldsEvent) {
      await _getAllFields(event, emit);
    } else if (event is GetChatCompletionEvent) {
      await _getAllChatCompletions(event, emit);
    } else if (event is DisposeFieldsControllersEvent) {
      _disposeAllFieldControllers();
    } else if (event is RegenerateChatCompletionEvent) {
      await _regenerateChatCompletions(event, emit);
    } else if (event is SummarizeChatCompletionEvent) {
      await _summarizeChatCompletions(event, emit);
    } else if (event is SelectFieldChatImageEvent) {
      homeBloc.imageUrl = null;
      homeBloc.file = File(event.file.path);
      emit(ImageSelectionSuccessState());
    } else if (event is ChangeLanguageEvent) {
      await _changeLanguageEvent(event, emit);
    } else if (event is EditingFormFieldEvent) {
      if (!event.validationErrorHasOccured) {
        emit(EditingTheFormState());
      } else {
        emit(FormFieldValidationErrorState());
      }
    } else if (event is TranslateGptResponseEvent) {
      await _onTranslateGPTResponse(event, emit);
    } else if (event is ProfileImageChangedEvent) {
      emit(ProfileImageSelectedState());
      // } else if (event is UpdateHistoryEvent) {
      //   await _updateHistory(event, emit);
    } else if (event is GetCompletionFromHistoryEvent) {
      await _getCompletionFromHistory(event, emit);
    } else if (event is GetEditTaskForHistoryEvent) {
      await _getTaskForHistory(event, emit);
    } else if (event is UpdateHistoryWithoutStateEvent) {
      await _updateHistoryWithoutStateEvent(event);
    } else if (event is GetFCMTokenEvent) {
      await _getFcmToken(event, emit);
    } else if (event is ChatCompletionLoadingEvent) {
      emit(ChatCompletionLoadingState());
    } else if (event is StopChatCompletionLoadingEvent) {
      emit(ChatCompletionInitialState());
    } else if (event is RegenerateChatCompletionCloseLoadingEvent) {
      emit(ChatRegenerationInitialState());
    } else if (event is RegenerateChatCompletionLoadingEvent) {
      emit(ChatRegenerationLoadingState());
    } else if (event is SummarizeChatCompletionLoadingEvent) {
      emit(ChatSummarizationLoadingState(isTranslated: false));
    } else if (event is StopSummarizeChatCompletionLoadingEvent) {
      emit(ChatSummarizeInitialState());
    } else if (event is RefreshAppLanguageEvent) {
      await _refreshAppLanguage(event, emit);
    }
  }

  Future<void> _refreshAppLanguage(
    RefreshAppLanguageEvent event,
    Emitter<HomeState> emit,
  ) async {
    final appLocale = await getIt<SharedPrefsManager>().getLocale();
    homeBloc.selectedLocale = appLocale;
    final locale = await saveUserLocaleSelection(homeBloc.selectedLocale);
    LogManager.log(head: 'RefreshAppLanguageEvent', msg: 'updating language');
    MyApp.setLocale(GlobalContext.currentContext!, locale);
    emit(LanguageChangedState());
  }

  Future<void> _changeLanguageEvent(
    ChangeLanguageEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.val == AppLocale.en.name) {
      homeBloc.selectedLocale = AppLocale.en;
    } else {
      homeBloc.selectedLocale = AppLocale.ar;
    }

    // Set the selectedLocal.name in the shared_pref
    Locale _locale = await saveUserLocaleSelection(homeBloc.selectedLocale);
    MyApp.setLocale(event.context, _locale);
    emit(LanguageChangedState());
  }

  Future<void> _checkForForceUpdate(
    ForceUpdateEvent event,
    Emitter<HomeState> emit,
  ) async {
    subscriptionBloc.add(LoadStatusEvent());
    if (Platform.isIOS) {
      if (await homeRepo.requireForceUpdate()) {
        await ForceUpdatePopup.show();
      }
    }
    // DLServices.initRoute();
    homeBloc.add(GetFCMTokenEvent());
    subscriptionBloc.add(UpdateSubscriptionStatusEvent(startTimer: true));
  }

  // handler
  Future<void> _getFcmToken(
    GetFCMTokenEvent event,
    Emitter<HomeState> emit,
  ) async {
    FirebaseMessaging.instance.requestPermission(provisional: true);
    bool isSentAlready =
        await getIt<SharedPrefsManager>().getData(PrefKeys.fcmKey) ?? false;

    if (!isSentAlready) {
      String? token = await homeRepo.getFCMToken();
      LogManager.log(head: 'FCM TOKEN', msg: token.toString());
      if (token != null) {
        // MyToast.simple(token);
        return emit(FcmTokenFetchSuccessState(token: token));
      }

      // ErrorMessages.display("Failed to fetch FCM Token");
      emit(FcmTokenFetchErrorState());
    }

    // profileBloc.add(GetUserProfileEvent());
  }

  Future<void> _updateHistoryWithoutStateEvent(
    UpdateHistoryWithoutStateEvent event,
  ) async {
    await HistoryRepo().updateHistory();
  }

  Future<void> _getTaskForHistory(
    GetEditTaskForHistoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(FieldsDataLoadingState());
    Map<String, dynamic> response = await homeRepo
        .getTaskFields(historyBloc.selectedHistory!.completionHistory!.taskId);

    if (response['data'] == null) {
      ErrorMessages.display(response['message']);
      emit(FieldsDataErrorState());
    } else if (response['data']['response'] == null) {
      MySnackbar.showSnackbar(response['message']);
      emit(FieldsDataErrorState());
    } else {
      FormModel formModel = FormModel.fromJson(response['data']['response']);
      formModel.prompts = List.from(homeBloc.form!.prompts);

      // Setting texts from the history
      Map<String, TextEditingController> textMap = {};
      for (FieldInfo field
          in historyBloc.selectedHistory!.completionHistory!.fieldInfo) {
        TextEditingController textController = TextEditingController();
        textController.text = field.input;

        textMap.addEntries({field.id: textController}.entries);
      }

      homeBloc.selectedOptions = {};
      for (FieldModel field in formModel.fields) {
        if (textMap.containsKey(field.id)) {
          if (field.isDropdown) {
            if (textMap[field.id]!.text.isNotEmpty) {
              FieldOption option = field.options
                  .firstWhere((opt) => opt.value == textMap[field.id]!.text);
              homeBloc.selectedOptions!.addEntries({field.id: option}.entries);
            }
          } else {
            field.textController = textMap[field.id];
          }
        }
      }

      if (formModel.isImage) {
        homeBloc.imageUrl =
            historyBloc.selectedHistory!.completionHistory!.imageUrl;
      }

      BuildContext ctx = GlobalContext.currentContext!;

      // Setting default lengths
      if (formModel.isLength) {
        String len = historyBloc.selectedHistory!.completionHistory!.length;
        homeBloc.length = homeBloc.getSelectedLength(ctx, len: len);
        homeBloc.lengthInLines = homeBloc.getLength(homeBloc.length, ctx);
      }

      // Setting default tones
      if (formModel.isTone) {
        String tone = historyBloc.selectedHistory!.completionHistory!.tone;
        homeBloc.tone = homeBloc.getSelectedTone(ctx, defTone: tone);
      }

      // Updating the form
      homeBloc.form = formModel;
      // homeBloc.form = FormModel.fromJson(tempFieldData);

      emit(FieldsDataSuccessState());
    }
  }

  void _disposeAllFieldControllers() {
    for (FieldModel field in homeBloc.form!.fields) {
      if (field.textController != null) field.textController!.dispose();
    }
  }

  Future<void> _getAllChatCompletions(
    GetChatCompletionEvent event,
    Emitter<HomeState> emit,
  ) async {
    List<FieldModel> fields = homeBloc.form!.fields;
    primaryFocus!.unfocus();

    // Validation for all required fields to be filled..
    // Incase not, the execution will not proceed,

    if (homeBloc.form!.isImage &&
        !homeBloc.form!.isImageOptional &&
        (homeBloc.imageUrl == null
            ? homeBloc.file == null
            : homeBloc.imageUrl!.isEmpty)) {
      ErrorMessages.display(lcGlobal.imageIsRequired);
      return emit(RequiredFormState());
    }

    for (FieldModel field in fields) {
      if (field.isDropdown
          ? (!field.optional && homeBloc.selectedOptions![field.id] == null)
          : (!field.optional && field.textController!.text.isEmpty)) {
        ErrorMessages.display(lcGlobal.someRequiredFieldsAreEmpty);
        emit(FormFieldValidationErrorState());
        return;
      }
    }

    homeBloc.form!.prompts.clear();
    // Since the form is completely validated, implementing the gpt call
    emit(ChatCompletionLoadingState());

    if (homeBloc.file != null) {
      // Upload the image to the server and save the url of the response
      Map<String, dynamic> response =
          await NetworkApiService().multipartApiCall(homeBloc.file!);
      if (response.containsKey("image_url")) {
        homeBloc.imageUrl = response['image_url'];
      } else {
        ErrorMessages.display(response['message']);
        return emit(ChatCompletionErrorState());
      }
    }

    // Condition for first prompt

    if (homeBloc.form!.prompts.isEmpty) {
      // Step 1: we have to generate the system prompt
      try {
        PromptModel sysPrompt = homeVMHelper.generateSystemPrompt(
          homeBloc.form!,
          homeBloc.lengthInLines ?? "",
          homeBloc.getSelectedTone(GlobalContext.currentContext!),
          fromEng: isEng,
          allowLength: homeBloc.form!.isLength,
        );

        homeBloc.form!.prompts.add(sysPrompt);
      } catch (e) {
        return emit(ChatCompletionErrorState());
      }
    }

    // Step 2: Add a user Prompt
    String content = "Generate";
    PromptModel userFirstPrompt = PromptModel(
      content: content,
      role: PromptRole.user,
      isInEng: isEng,
    );
    homeBloc.form!.prompts.add(userFirstPrompt);
    Map<String, dynamic> response = {};
    if (homeBloc.file != null && homeBloc.imageUrl != null) {
      response = await homeRepo.generateChatVision(
        homeBloc.imageUrl!,
        homeBloc.form!.prompts,
      );
    } else if (homeBloc.file != null && homeBloc.imageUrl == null) {
      return;
    } else {
      response = await homeRepo
          .generateChatCompletion(homeBloc.form!.getPromptsJson());
    }
    if (response.containsKey("error")) {
      ErrorMessages.display(response['error']['message']);
      emit(ChatCompletionErrorState());
    } else {
      try {
        Map<String, dynamic> chatResponse = response['choices'][0]['message'];
        PromptModel assistantPrompt = PromptModel.fromJson(chatResponse);
        homeBloc.form!.prompts.add(assistantPrompt);
        // Creating the history
        await HistoryRepo().createHistory();
        emit(ChatCompletionSuccessState());
      } catch (e) {
        ErrorMessages.display("Error Parsing the data");
        return emit(ChatCompletionErrorState());
      }
    }
  }

  Future<void> _summarizeChatCompletions(
    SummarizeChatCompletionEvent event,
    Emitter<HomeState> emit,
  ) async {
    // if (homeBloc.state is! ChatSummarizationLoadingState) {
    //   emit(ChatSummarizationLoadingState(isTranslated: event.isTranslated));
    // }
    // Since the form is completely validated, implementing the gpt call
    // emit(ChatSummarizationLoadingState(isTranslated: event.isTranslated));
    String arabicTrans =
        isEng && event.isTranslated ? "Generate Response in Arabic only" : "";

    // Step 2: Add a user Prompt
    String content = 'Summarize this $arabicTrans: "${event.content}"';

    PromptModel chatPrompt = PromptModel(
      content: content,
      role: PromptRole.user,
      isInEng: isEng,
    );
    Map<String, dynamic> response =
        await homeRepo.summarizeChatCompletion(chatPrompt.toJson());
    if (response.containsKey("error")) {
      emit(ChatSummarizationErrorState(message: response['error']['message']));
    } else {
      Map<String, dynamic> chatResponse = response['choices'][0]['message'];
      PromptModel assistantPrompt = PromptModel.fromJson(chatResponse);
      emit(ChatSummarizationSuccessState(response: assistantPrompt));
    }
  }

  Future<void> _regenerateChatCompletions(
    RegenerateChatCompletionEvent event,
    Emitter<HomeState> emit,
  ) async {
    // emit(RegenerateChatCompletionLoadingEvent());
    if (event.fromHistory) {
      List<FieldModel> fields = homeBloc.form!.fields;
      primaryFocus!.unfocus();
      if (homeBloc.form!.isImage &&
          !homeBloc.form!.isImageOptional &&
          (homeBloc.imageUrl == null
              ? homeBloc.file == null
              : homeBloc.imageUrl!.isEmpty)) {
        ErrorMessages.display(lcGlobal.imageIsRequired);
        return emit(RequiredFormState());
      }

      for (FieldModel field in fields) {
        if (field.isDropdown
            ? (!field.optional && homeBloc.selectedOptions![field.id] == null)
            : (!field.optional && field.textController!.text.isEmpty)) {
          ErrorMessages.display(lcGlobal.someRequiredFieldsAreEmpty);
          emit(FormFieldValidationErrorState());
          return;
        }
      }
    }
    // Since the form is completely validated, implementing the gpt call
    emit(ChatRegenerationLoadingState());

    // Step 2: Add a user Prompt
    String content = "Re-generate";
    PromptModel userFirstPrompt = PromptModel(
      content: content,
      role: PromptRole.user,
      isInEng: isEng,
    );
    homeBloc.form!.prompts.add(userFirstPrompt);

    Map<String, dynamic> response = {};
    if (homeBloc.file != null && homeBloc.imageUrl != null) {
      response = await homeRepo.generateChatVision(
        homeBloc.imageUrl!,
        homeBloc.form!.prompts,
      );
    } else {
      response = await homeRepo
          .generateChatCompletion(homeBloc.form!.getPromptsJson());
    }
    if (response.containsKey("error")) {
      ErrorMessages.display(response['error']['message']);
      emit(ChatRegenerationErrorState());
    } else {
      Map<String, dynamic> chatResponse = response['choices'][0]['message'];
      PromptModel assistantPrompt = PromptModel.fromJson(chatResponse);

      homeBloc.form!.prompts.add(assistantPrompt);

      emit(ChatRegenerationSuccessState());
    }
  }

  Future<void> _getAllFields(
    GetFieldsEvent event,
    Emitter<HomeState> emit,
  ) async {
    homeBloc.tone = "";
    homeBloc.imageUrl = null;
    homeBloc.length = "";
    homeBloc.lengthInLines = "";
    homeBloc.selectedOptions = {};
    emit(FieldsDataLoadingState());
    // Function call to get Fields from the backend
    String taskId = homeBloc.selectedTask!.id;
    // "65d4de42322503da96c8d480"
    // "65d4f21e5dbbe37fc60c0404"
    Map<String, dynamic> response = await homeRepo.getTaskFields(taskId);

    if (response['data'] == null) {
      ErrorMessages.display(response['message']);
      emit(FieldsDataErrorState());
    } else if (response['data']['response'] == null) {
      MySnackbar.showSnackbar(response['message']);
      emit(FieldsDataErrorState());
    } else {
      homeBloc.form = null;

      FormModel formModel = FormModel.fromJson(response['data']['response']);

      homeBloc.form = formModel;
      // homeBloc.form = FormModel.fromJson(tempFieldData);

      emit(FieldsDataSuccessState());
    }
  }

  void _setSelectedTask(SelectTaskEvent event, Emitter<HomeState> emit) {
    homeBloc.file = null;
    homeBloc.selectedTask = event.task;
    event.context.pushNamed(FieldsScreen.route);
    emit(SelectTaskSuccessState());
  }

  void _setSelectedCategory(
    SelectCategoryEvent event,
    Emitter<HomeState> emit,
  ) {
    homeBloc.selectedCategory = event.category;
    event.context.pushNamed(TasksScreen.route);
    emit(SelectCategorySuccessState());
  }

  Future<void> _getAllTasks(
    GetTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(TaskDataLoadingState());
    homeBloc.tasks.clear();
    try {
      Map<String, dynamic> response =
          await homeRepo.getAllTasks(homeBloc.selectedCategory!.id);

      if (response['data'] == null || response['data']['response'] == null) {
        ErrorMessages.display(response['message']);
        emit(TaskDataErrorState());
      } else {
        List<TaskModel> tasks = [];

        for (Map<String, dynamic> task in response['data']['response']) {
          TaskModel taskModel = TaskModel.fromJson(task);
          tasks.add(taskModel);
        }

        tasks.sort((a, b) => a.sorting.compareTo(b.sorting));

        homeBloc.tasks = tasks;
        emit(TaskDataSuccessState());
      }
    } catch (e) {
      ErrorMessages.display(e.toString());
      return emit(TaskDataErrorState());
    }
  }

  Future<void> _getAllCategories(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (homeBloc.categories.isNotEmpty) return;
    emit(HomeDataLoadingState());
    homeBloc.categories.clear();
    try {
      Map<String, dynamic> response = await homeRepo.getAllCategories();
      if (response['data'] == null || response['data']['response'] == null) {
        ErrorMessages.display(response['message']);
        emit(HomeDataErrorState());
      } else {
        List<HomeCategoryModel> categories = [];

        for (Map<String, dynamic> category in response['data']['response']) {
          HomeCategoryModel categoryModel =
              HomeCategoryModel.fromJson(category);
          categories.add(categoryModel);
        }

        homeBloc.categories = categories;
        homeBloc.categories.sort((a, b) => a.sorting.compareTo(b.sorting));
        emit(HomeDataSuccessState());
      }
    } catch (e) {
      ErrorMessages.display(e.toString());
      return emit(HomeDataErrorState());
    }
  }

  Future<void> _onTranslateGPTResponse(
    TranslateGptResponseEvent event,
    Emitter<HomeState> emit, {
    bool emitStates = true,
  }) async {
    if (event.prompt.translatedContent.isNotEmpty) {
      event.prompt.toggleTranslation();
      return emitStates ? emit(TranslateFromCacheSuccessState()) : null;
    }
    event.prompt.isTranslatingTapped = true;
    if (emitStates) emit(TranslateGptResponseLoadingState());
    Map<String, dynamic> response =
        await homeRepo.translateText(event.prompt, event.translateInEng);
    if (response.isNotEmpty) {
      if (response.containsKey("error")) {
        ErrorMessages.display(response['error']['message']);
        event.prompt.isTranslatingTapped = false;
        return emitStates ? emit(TranslateGptResponseErrorState()) : null;
      } else {
        event.prompt.translatedContent =
            response['data']['translations'][0]['translatedText'];
        event.prompt.toggleTranslation();
        event.prompt.isTranslatingTapped = false;
        return emitStates ? emit(TranslateGptResponseSuccessState()) : null;
      }
    }
  }

  Future<void> _getCompletionFromHistory(
    GetCompletionFromHistoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    CustomCupertinoLoader.showLoaderDialog();
    HistoryModel? response =
        await HistoryRepo().getHistoryById(id: historyBloc.selectedHistory!.id);
    CustomCupertinoLoader.dispose();
    if (response == null) {
      ErrorMessages.display(lcGlobal.unableToGetHistory);
    } else {
      // Setting selected category
      CompletionHistoryModel history = response.completionHistory!;
      homeBloc.selectedCategory = HomeCategoryModel(
        id: history.catId,
        description: "",
        imageUrl: "",
        title: history.catName,
        translatedTitle: history.catTranslatedName,
        translatedDescription: "",
        sorting: "0",
      );

      // Setting selected task
      homeBloc.selectedTask = TaskModel(
        id: history.taskId,
        title: history.taskName,
        description: "",
        translatedTitle: history.taskTranslatedName,
        translatedDescription: "",
        prompt: history.prompt,
        sorting: "0",
      );

      // Typecasting history prompts to PromptModels
      List<PromptModel> prompts = history.responsesToPromptsList();

      // Adding Promtps to form for routing
      homeBloc.form = FormModel.onlyPrompts(prompts);

      Widget route = const ChatResponseScreen(fromHistory: true);
      GlobalContext.currentContext!.pushRoute(route);
    }
  }
}
