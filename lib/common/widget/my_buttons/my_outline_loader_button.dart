import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

import '../../../theme/my_colors.dart';

class MyOutlineLoaderButton extends StatelessWidget {
  final bool loader;
  final VoidCallback? onPressed;
  final String text;
  final Widget? prefixIcon, suffixIcon;
  final Color? disabledTextColor, textColor;
  final double height, loaderWidth;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  const MyOutlineLoaderButton({
    Key? key,
    required this.text,
    required this.loader,
    this.onPressed,
    this.height = 52,
    this.loaderWidth = 52,
    this.disabledTextColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.textStyle,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        padding: padding,
        decoration: BoxDecoration(
          color: MyColors.transparent,
          borderRadius: BorderRadius.circular(loader ? 30 : 6),
          border: Border.all(
            color:
                onPressed != null ? MyColors.black0D0D0D : MyColors.transparent,
          ),
        ),
        duration: const Duration(milliseconds: 500),
        height: height.pxH(context),
        width: loader
            ? loaderWidth
            : width == null
                ? 100.percentWidth(context)
                : width!.pxH(context),
        child: loader
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? MyColors.white,
                    ),
                  ),
                ),
              )
            : OutlinedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      prefixIcon ?? const SizedBox(),
                      const SizedBox(width: 10),
                      TextView(loader ? "" : text,
                          textAlign: TextAlign.center,
                          maxLine: 1,
                          style: textStyle),
                      const SizedBox(width: 10),
                      suffixIcon ?? const SizedBox(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
