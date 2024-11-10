import 'package:roboti_app/presentation/home/model/prompt_model.dart';

extension TranslatedPromptExtension on List<PromptModel> {
  bool hasTranslatedAssistantPrompt() {
    for (PromptModel prompt in this) {
      if (prompt.isAssistantPrompt && prompt.isTranslatingTapped) {
        return true;
      }
    } 
    return false;
  }
}
