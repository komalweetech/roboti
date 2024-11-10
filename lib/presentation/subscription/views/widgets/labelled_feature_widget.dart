import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/text_styling.dart';

class LablledFeatureWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  const LablledFeatureWidget({
    super.key,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon
        SvgPicture.asset(
          iconPath,
        ),
        const SizedBox(width: 15),
        // Text
        TextView(text, style: myTextStyle.font_16wRegular),
      ],
    );
  }
}
