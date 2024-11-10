import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final EdgeInsets margin;
  const DividerWithText({
    super.key,
    required this.style,
    required this.text,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: MyColors.black7B8598,
              height: 1.pxV(context),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: TextView(text, style: style)),
          Expanded(
            child: Container(
              color: MyColors.black7B8598,
              height: 1.pxV(context),
            ),
          ),
        ],
      ),
    );
  }
}
