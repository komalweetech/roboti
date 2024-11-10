import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_elevated_button.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_events.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_states.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/ui/screen/fields_screen.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/gpt_response_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/summary_response.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_popup_screen.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/membership_pop_up.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class ChatResponseScreen extends StatefulWidget {
  static const route = "chat_response_screen.dart";
  final bool fromHistory;
  const ChatResponseScreen({
    super.key,
    this.fromHistory = false,
  });

  @override
  State<ChatResponseScreen> createState() => _ChatResponseScreenState();
}

class _ChatResponseScreenState extends State<ChatResponseScreen> {
  bool _onClose() {
    if (widget.fromHistory) {
      context.pop();
      return false;
    }
    context.pop();
    context.pop();
    return false;
  }

  void _onEditTaskTap(HomeState state) {
    if (widget.fromHistory) {
      // homeBloc.add(GetEditTaskForHistoryEvent());
      context.pushRoute(const FieldsScreen(fromHistory: true));
    } else {
      if (state is! LoaderState) context.pop();
    }
  }

  PreferredSizeWidget appBar(HistoryStates state) {
    return MyAppBar(
      leadingWidget: MyBackButton(
        onTap: () => _onClose(),
      ),
      title: const MyLogoWidget(),
      actionWidgets: [
        if (state is UpdateHistoryLoadingState)
          CustomCupertinoLoader.showLoaderWidget()
        else
          0.vSpace(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryStates>(
      bloc: historyBloc,
      builder: (context, historyState) => SubscriptionPopStackedWidget(
        onInit: () {},
        onDispose: () {
          if (widget.fromHistory && historyBloc.history.isEmpty) {
            historyBloc.add(GetAllHistoryEvent());
          }
        },
        appbar: appBar(historyState),
        screen: WillPopScope(
          onWillPop: () async => _onClose(),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is ChatSummarizationLoadingState) {
                SummaryResponse.showResponse(
                  context,
                  state.isTranslated,
                  widget.fromHistory,
                );
              }

              if (state is ChatRegenerationSuccessState ||
                  state is TranslateGptResponseSuccessState) {
                historyBloc.add(UpdateHistoryEvent());
              }
            },
            builder: (context, state) => ListView(
              padding: 20.paddingH(context),
              physics: const BouncingScrollPhysics(),
              children: [
                TextView(
                  isEng
                      ? "${homeBloc.selectedCategory!.title} / ${homeBloc.selectedTask!.title}"
                      : "${homeBloc.selectedCategory!.translatedTitle} / ${homeBloc.selectedTask!.translatedTitle}",
                  style: myTextStyle.font_16wRegular
                      .textColor(MyColors.blue6B79AD),
                ),
                for (int i = 0; i < getAssistantPrompts().length; i++)
                  GPTResponseWidget(
                    index: i + 1,
                    total: getAssistantPrompts().length,
                    prompt: getAssistantPrompts()[i],
                    showSummarization:
                        getAssistantPrompts()[i].allowSummarization,
                    alreadyTranslated: false,
                    fromHistory: widget.fromHistory,
                  ),
                26.7.vSpace(context),
                MyLoaderElvButton(
                  prefixIcon: SvgPicture.asset(MyIcons.regenerateIcon),
                  buttonBGColor: MyColors.pinFieldBlue141F48,
                  text: lc(context).reGenerate,
                  textColor: MyColors.white,
                  textStyle: myTextStyle.font_16wRegular,
                  state: state,
                  onPressed: () => _onGenerateTap(),
                ),
                16.vSpace(context),
                MyElevatedButton(
                  prefixIcon: SvgPicture.asset(MyIcons.editIcon),
                  buttonBGColor: MyColors.pinFieldBlue141F48,
                  text: lc(context).editTask,
                  textColor: MyColors.white,
                  textStyle: myTextStyle.font_16wRegular,
                  onPressed: () => _onEditTaskTap(state),
                ),
                10.percentHeight(context).vSpace(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onGenerateTap() {
    homeBloc.add(RegenerateChatCompletionLoadingEvent());
    TrialRequestHandler(
      context: context,
      onAllowed: () {
        homeBloc.add(RegenerateChatCompletionEvent());
      },
    ).handleTrialRequest(
        () => homeBloc.add(RegenerateChatCompletionCloseLoadingEvent()));
  }

  List<PromptModel> getAssistantPrompts() {
    return homeBloc.form!.prompts
        .where((element) => element.isAssistantPrompt)
        .toList();
  }
}
