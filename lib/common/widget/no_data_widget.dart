import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final int flex1, flex2;
  const NoDataWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.flex1 = 1,
    this.flex2 = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: flex1),
        Center(
          child: Text(
            text,
            style: myTextStyle.font_16wRegular.copyWith(
              color: MyColors.grey4E5067,
              fontSize: fontSize,
            ),
          ),
        ),
        Spacer(flex: flex2),
      ],
    );
  }
}
