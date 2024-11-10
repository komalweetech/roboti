import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/labelled_text.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/membership_pop_up.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';
import 'package:share_plus/share_plus.dart';

class GPTResponseWidget extends StatefulWidget {
  final PromptModel prompt;
  final int index;
  final int total;
  final EdgeInsets? margin;
  final bool showRating, showSummarization, showDivider, showTranslation;
  final bool alreadyTranslated;
  final bool fromHistory;
  const GPTResponseWidget({
    super.key,
    required this.prompt,
    required this.index,
    required this.total,
    required this.alreadyTranslated,
    this.margin,
    this.showRating = true,
    this.showSummarization = true,
    this.showDivider = true,
    this.showTranslation = true,
    required this.fromHistory,
  });

  @override
  State<GPTResponseWidget> createState() => _GPTResponseWidgetState();
}

class _GPTResponseWidgetState extends State<GPTResponseWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? 20.paddingBottom(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            "${widget.index}/${widget.total}",
            style: myTextStyle.font_16wRegular.textColor(MyColors.blue6B79AD),
          ),
          if (widget.prompt.animated)
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => TextView(
                getText(state),
                style: myTextStyle.font_20wMedium,
                textAlign: textAlignment,
                alignment: textAlignment == TextAlign.right
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
              ),
            )
          else
            CompletionAnimatedTextWidget(
              duration: const Duration(milliseconds: 50),
              prompt: widget.prompt,
              alignment: textAlignment,
              onFinished: () {
                if (mounted) {
                  setState(() => widget.prompt.animated = true);
                }
              },
            ),
          8.vSpace(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      LabeledText(
                        onTap: () async {
                          String data = widget.prompt.isTranslated
                              ? widget.prompt.translatedContent
                              : widget.prompt.content;
                          if (data.isNotEmpty) {
                            await Share.share(data);
                          } else {
                            MySnackbar.showSnackbar(
                                lc(context).emptyMessageCannotBeShared);
                          }
                        },
                        icon: MyIcons.shareIcon,
                        text: lc(context).share,
                        textColor: MyColors.blue6C63FF,
                      ),
                      32.hSpace(context),
                      LabeledText(
                        onTap: () async {
                          String data = widget.prompt.isTranslated
                              ? widget.prompt.translatedContent
                              : widget.prompt.content;
                          await FlutterClipboard.copy(data);
                        },
                        icon: MyIcons.copyIcon,
                        text: lc(context).copy,
                        textColor: MyColors.blue2575FC,
                      ),
                    ],
                  ),
                  if (widget.showRating) ...[
                    18.vSpace(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          lc(context).rateThisContent,
                          style: myTextStyle.font_16wRegular,
                        ),
                        12.6.vSpace(context),
                        Row(
                          children: [1, 2, 3, 4, 5].map(
                            (index) {
                              return Padding(
                                padding: 14.3.paddingRight(context),
                                child: InkWell(
                                  splashColor: MyColors.transparent,
                                  onTap: () => {
                                    setState(
                                        () => widget.prompt.ratings = index),
                                    homeBloc
                                        .add(UpdateHistoryWithoutStateEvent()),
                                  },
                                  child: SvgPicture.asset(
                                    index <= widget.prompt.ratings
                                        ? MyIcons.starFilledIcon
                                        : MyIcons.starIcon,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Translation Button
                  if (widget.showTranslation)
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) => LabeledText(
                        onTap: () => homeBloc.add(
                          TranslateGptResponseEvent(
                            prompt: widget.prompt,
                            translateInEng: !isInEng,
                          ),
                        ),
                        // translate(translateInEng: !isEng);

                        icon: MyIcons.translationIcon,
                        text: isTranslationTap(state)
                            ? lc(context).translating
                            : "${lc(context).translateTo} ${isInEng ? widget.prompt.isTranslated ? lc(context).english : lc(context).arabic : widget.prompt.isTranslated ? lc(context).arabic : lc(context).english}",
                        textColor: MyColors.softPinkFD6AF5,
                      ),
                    ),
                  14.vSpace(context),
                  if (widget.showSummarization)
                    LabeledText(
                      onTap: _onGenerateTap,
                      icon: MyIcons.summaryIcon,
                      text: lc(context).summarize,
                      textColor: MyColors.limeGreen67FF66,
                    ),
                ],
              ),
            ],
          ),
          if (widget.showDivider) ...[
            27.9.vSpace(context),
            Container(
              height: 1,
              width: 100.percentWidth(context),
              color: MyColors.blue2575FC,
            ),
          ]
        ],
      ),
    );
  }

  void _onGenerateTap() {
    homeBloc.add(SummarizeChatCompletionLoadingEvent(
      isTranslated: widget.prompt.isTranslated,
    ));
    TrialRequestHandler(
      context: context,
      onAllowed: () => homeBloc.add(
        SummarizeChatCompletionEvent(
          content: widget.prompt.content,
          isTranslated: widget.prompt.isTranslated,
        ),
      ),
    ).handleTrialRequest(() {
      context.pop();
      homeBloc.add(StopSummarizeChatCompletionLoadingEvent());
    });
  }

  String getText(state) {
    if (isInEng) {
      // English
      if (widget.prompt.isTranslated) return widget.prompt.translatedContent;
      return widget.prompt.content;
    } else {
      // Arabic
      if (widget.prompt.isTranslated) {
        if (widget.prompt.translatedContent.isNotEmpty) {
          return widget.prompt.translatedContent;
        }
        return widget.prompt.content;
      } else {
        if (widget.prompt.content.isEmpty) {
          return widget.prompt.translatedContent;
        }
        return widget.prompt.content;
      }
    }

    // isEng
    //   ? widget.prompt.isTranslated || (widget.alreadyTranslated)
    //       ? widget.prompt.translatedContent
    //       : widget.prompt.content
    //   : !widget.prompt.isTranslated
    //       ? widget.prompt.content
    //       : widget.prompt.translatedContent;
  }

  bool get isInEng => widget.fromHistory ? widget.prompt.isInEng : isEng;

  bool isTranslationTap(HomeState state) {
    return state is TranslateGptResponseLoadingState &&
        widget.prompt.isTranslatingTapped;
  }

  TextAlign get textAlignment => isInEng
      ? widget.prompt.isTranslated || (widget.alreadyTranslated)
          ? TextAlign.right
          : TextAlign.left
      : widget.prompt.isTranslated
          ? TextAlign.left
          : TextAlign.right;
}

class CompletionAnimatedTextWidget extends StatefulWidget {
  final PromptModel prompt;
  final Duration duration;
  final Function() onFinished;
  final TextAlign alignment;
  const CompletionAnimatedTextWidget({
    super.key,
    required this.prompt,
    required this.duration,
    required this.onFinished,
    required this.alignment,
  });

  @override
  State<CompletionAnimatedTextWidget> createState() =>
      _CompletionAnimatedTextWidgetState();
}

class _CompletionAnimatedTextWidgetState
    extends State<CompletionAnimatedTextWidget> {
  @override
  void initState() {
    animate();
    super.initState();
  }

  void animate() async {
    if (!widget.prompt.animated) {
      List<String> values = text.split(" ");
      int index = 0;
      widget.prompt.timer = Timer.periodic(
        widget.duration,
        (timer) {
          if (index < values.length) {
            widget.prompt.animatedMessages =
                "${widget.prompt.animatedMessages}${values[index]} ";
            index++;
            if (mounted) setState(() {});

            if (widget.prompt.animatedMessages.length >= text.length) {
              widget.prompt.timer!.cancel();
              widget.onFinished();
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextView(
          widget.prompt.animatedMessages,
          style: myTextStyle.font_20wMedium,
          textAlign: widget.alignment,
          alignment: widget.alignment == TextAlign.right
              ? Alignment.centerRight
              : Alignment.centerLeft,
        ),
        if (widget.prompt.animatedMessages.length <= text.length)
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: MyColors.white,
            ),
          ),
      ],
    );
  }

  String get text => widget.prompt.isTranslated
      ? widget.prompt.translatedContent
      : widget.prompt.content;
}
