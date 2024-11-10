import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class InstructionWidget extends StatefulWidget {
  final Function() onTermsAndPoliciesTap, onPrivacyPolicyTap;
  const InstructionWidget({
    super.key,
    required this.onPrivacyPolicyTap,
    required this.onTermsAndPoliciesTap,
  });

  @override
  State<InstructionWidget> createState() => _InstructionWidgetState();
}

class _InstructionWidgetState extends State<InstructionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: 46.paddingH(context),
            child: Text.rich(
              TextSpan(
                text: lc(context).bySigningUpYouAgreeToOur,
                children: [
                  TextSpan(
                    text: lc(context).termOfService,
                    style: myTextStyle.font_12w700
                        .copyWith(color: MyColors.green658F7B),
                    onEnter: (event) {},
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: myTextStyle.font_12w500Black,
            ),
          ),
          Padding(
            padding: 46.paddingH(context),
            child: Text.rich(
              TextSpan(
                text: lc(context).andAcknowledgeThatOur,
                children: [
                  TextSpan(
                    text: lc(context).privacyPolicy,
                    style: myTextStyle.font_12w700
                        .copyWith(color: MyColors.green658F7B),
                  ),
                  TextSpan(text: lc(context).applies),
                ],
              ),
              textAlign: TextAlign.center,
              style: myTextStyle.font_12w500Black,
            ),
          ),
          Padding(
            padding: 46.paddingH(context),
            child: Text(
              lc(context).toYou,
              textAlign: TextAlign.center,
              style: myTextStyle.font_12w500Black,
            ),
          ),
        ],
      ),
    );
  }
}
