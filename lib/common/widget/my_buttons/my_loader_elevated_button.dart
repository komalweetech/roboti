import 'package:flutter/material.dart';
import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

import '../../../theme/my_colors.dart';

class MyLoaderElvButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final dynamic state;
  final String text;
  final Widget? prefixIcon, suffixIcon;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double height, loaderWidth;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final Gradient gradient;
  final bool showLoader;

  const MyLoaderElvButton({
    super.key,
    required this.text,
    required this.state,
    this.onPressed,
    this.buttonBGColor,
    this.height = 76,
    this.loaderWidth = 65,
    this.disabledTextColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.width,
    this.padding = EdgeInsets.zero,
    this.gradient = MyColors.gradient601FD2x2575FC,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        margin: padding,
        decoration: BoxDecoration(
          color: onPressed != null
              ? buttonBGColor ?? MyColors.black0D0D0D
              : MyColors.transparent,
          borderRadius: BorderRadius.circular(loader ? 300 : 8),
          gradient: buttonBGColor == null ? gradient : null,
        ),
        duration: const Duration(milliseconds: 500),
        height: height.pxH(context),
        width: loader
            ? height.pxH(context)
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
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    // onPressed != null ? MyColors.gradient0014FFTo00E5FF : null,
                    Colors.transparent,
                  ),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(loader ? 30.0 : 8),
                    ),
                  ),
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      prefixIcon ?? const SizedBox(),
                      const SizedBox(width: 10),
                      TextView(
                        loader ? "" : text,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                        style: textStyle,
                      ),
                      const SizedBox(width: 10),
                      suffixIcon ?? const SizedBox(),
                    ],
                  ),
                ),
                // ),
              ),
      ),
    );
  }

  bool get loader => state is LoaderState || showLoader;
}
