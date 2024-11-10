import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/model/form_model.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';

class HomeVMHelper {
  PromptModel generateSystemPrompt(
    FormModel form,
    String length,
    String tone, {
    required bool fromEng,
    required bool allowLength,
  }) {
    String prompt = form.basePrompt;

    Map<String, dynamic> promptReplacer = _getPromptReplacerMap(form.fields);

    if (prompt.contains("\n")) {
      prompt = prompt.replaceAll("\n", " ");
    }

    List<String> promptWords = prompt.split(" ");
    String toneName = form.toneName;
    String lengthName = form.lengthName;

    for (int index = 0; index < promptWords.length; index++) {
      String word = promptWords[index];
      if (word == toneName) {
        word = tone;
      } else if (word == lengthName) {
        word = length;
      } else {
        word = _removeSquareBrackets(promptWords[index]);
      }

      promptWords[index] = promptReplacer[word] ?? word;
    }

    // if (allowLength) {
    //   promptWords.add("\n(Generate Response with max lines $length)");
    // }

    if (!fromEng) {
      promptWords.add("\n(Reply In Arabic Only)");
    }

    String finalPrompt = promptWords.join(" ");

    return PromptModel(
      content: finalPrompt,
      role: PromptRole.system,
      isInEng: isEng,
    );
  }

  Map<String, dynamic> _getPromptReplacerMap(List<FieldModel> fields) {
    Map<String, String> replacer = {};

    for (FieldModel field in fields) {
      String label = _removeSquareBrackets(field.name).toUpperCase();
      String value = field.textController?.text ?? "";
      if (field.isDropdown) {
        value = isEng
            ? homeBloc.selectedOptions![field.id]?.text ?? ""
            : homeBloc.selectedOptions![field.id]?.arabicText ?? "";
      }
      replacer.addEntries({label: value}.entries);
    }

    return replacer;
  }

  String _removeSquareBrackets(String data) {
    // if (data.contains("[") && data.contains("]")) {
    //   return data.substring(1, data.length - 1);
    // } else if (data.contains("[")) {
    //   return data.substring(1);
    // } else if (data.contains("]")) {
    //   return data.substring(0, data.length - 1);
    // } else {
    //   return data;
    // }
    if (data.contains("[")) {
      data = data.replaceAll("[", "");
    }

    if (data.contains("]")) {
      data = data.replaceAll("]", "");
    }

    return data;
  }
}
