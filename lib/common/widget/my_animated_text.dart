import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';

class MyAnimatedText extends StatelessWidget {
  final Function()? onFinished;
  final Function(int, bool)? onNext;
  final String message;
  final TextStyle style;
  final TextAlign textAlign;

  const MyAnimatedText({
    super.key,
    required this.message,
    this.onFinished,
    this.onNext,
    required this.style,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      onFinished: onFinished,
      stopPauseOnTap: true,
      onTap: () {
        LogManager.log(head: 'AnimatedTextKit', msg: 'TAPPED');
      },
      onNext: onNext,

      totalRepeatCount: 1,
      // pause: Duration(milliseconds: 4000),
      animatedTexts: [
        TypewriterAnimatedText(
          message,
          speed: const Duration(milliseconds: 10),
          curve: Curves.linear,
          cursor: "●",
          textStyle: style,
          textAlign: textAlign,
        ),
      ],
      // child: Text(
      //   chat.message,
      //   style: myTextStyle.font_16wRegular,
      // ),
    );
  }
}
