import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/home/model/category_model.dart';
import 'package:roboti_app/presentation/home/model/field_options.dart';
import 'package:roboti_app/presentation/home/model/form_model.dart';
import 'package:roboti_app/presentation/home/model/task_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_events_handler.dart';

final HomeBloc homeBloc = HomeBloc(
  categories: [],
  tasks: [],
  length: "",
  tone: "",
  selectedLocale: AppLocale.en,
  lengthInLines: null,
  loginResponse: LoginResponse.initial(),
);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<HomeCategoryModel> categories;
  HomeCategoryModel? selectedCategory;
  TaskModel? selectedTask;
  List<TaskModel> tasks;
  FormModel? form;
  String? imageUrl;
  File? file;
  String tone;
  String length;
  String? lengthInLines;
  Map<String, FieldOption>? selectedOptions = {};
  final LoginResponse loginResponse;

  AppLocale selectedLocale = AppLocale.en;

  HomeBloc({
    required this.categories,
    required this.tasks,
    this.form,
    this.selectedCategory,
    this.selectedTask,
    required this.length,
    required this.tone,
    required this.selectedLocale,
    required this.lengthInLines,
    this.selectedOptions,
    required this.loginResponse,
  }) : super(HomeInitialState()) {
    on<HomeEvent>(HomeEventsHandler().homeHandler);
  }

  String getSelectedTone(BuildContext context, {String? defTone}) {
    String val = defTone?.toLowerCase() ?? tone.toLowerCase();
    if (val.isEmpty) return "";

    List<List<String>> tones = [
      ["normal", "طبيعي"],
      ["friendly", "ودي"],
      ["lovely", "محبوب"],
      ["sad", "حزين"],
      ["formal", "رَسمِيّ"],
      ["angry", "غاضب"],
    ];

    if (tones[0].contains(val)) {
      // normal
      return lc(context).normal;
    } else if (tones[1].contains(val)) {
      // friendly
      return lc(context).friendly;
    } else if (tones[2].contains(val)) {
      // lovely
      return lc(context).lovely;
    } else if (tones[3].contains(val)) {
      // sad
      return lc(context).sad;
    } else if (tones[4].contains(val)) {
      // formal
      return lc(context).formal;
    } else if (tones[5].contains(val)) {
      // angry
      return lc(context).angry;
    } else {
      return lc(context).happy;
    }
    // switch (val.toLowerCase()) {
    //   case "normal" || "طبيعي":
    //     return lc(context).normal;
    //   case "friendly" || "ودي":
    //     return lc(context).friendly;
    //   case "lovely" || "محبوب":
    //     return lc(context).lovely;
    //   case "sad" || "حزين":
    //     return lc(context).sad;
    //   case "formal" || "رَسمِيّ":
    //     return lc(context).formal;
    //   case "angry" || "غاضب":
    //     return lc(context).angry;
    //   default:
    //     return lc(context).happy;
    // }
  }

  String getSelectedLength(BuildContext context, {String? len}) {
    String val = len ?? length;
    if (val.isEmpty) return "";

    switch (val.toLowerCase()) {
      case "short" || "قصير":
        return lc(context).short;
      case "medium" || "متوسط":
        return lc(context).medium;
      default:
        return lc(context).long;
    }
  }

  String getLength(String val, BuildContext context) {
    if (val.isNotEmpty) {
      final String short = lc(context).short;
      final String medium = lc(context).medium;
      if (val == short) {
        return "Minimum 5 lines";
      } else if (val == medium) {
        return "Minimum 12 lines";
      } else {
        return "Minimum 17 lines";
      }
    }
    return "";
  }
}
