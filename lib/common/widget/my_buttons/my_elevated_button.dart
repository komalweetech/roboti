import 'package:roboti_app/common/widget/text_view.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

import '../../../theme/my_colors.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? prefixIcon, suffixIcon;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double height, iconSpacing, buttonRadius;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Gradient gradient;
  final BorderRadiusGeometry? borderRadius;

  const MyElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.buttonBGColor,
    this.height = 76,
    this.disabledTextColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.width,
    this.borderRadius,
    this.padding,
    this.iconSpacing = 10,
    this.buttonRadius = 8,
    this.gradient = MyColors.gradient601FD2x2575FC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(10);
    return Container(
      padding: padding,
      margin: padding,
      height: height.pxV(context),
      width: width == null
          ? MediaQuery.sizeOf(context).width
          : width!.pxH(context),
      decoration: BoxDecoration(
        gradient: buttonBGColor == null ? gradient : null,
        borderRadius: borderRadius,
        color: buttonBGColor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: FittedBox(
          child: Row(
            children: [
              prefixIcon ?? const SizedBox(),
              SizedBox(width: iconSpacing),
              TextView(
                text,
                textAlign: TextAlign.center,
                maxLine: 1,
                style: textStyle,
              ),
              SizedBox(width: iconSpacing),
              suffixIcon ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
