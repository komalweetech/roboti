import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/my_svg_icon.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';

class MyCheckBoxFilter extends StatelessWidget {
  const MyCheckBoxFilter({
    Key? key,
    this.onPressed,
    this.checkBoxValue = false,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final bool checkBoxValue;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: SizedBox(
          height: 30.0,
          width: 20.0,
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(child: child, scale: animation);
              },
              child: checkBoxValue
                  ? SvgIconCustom(
                      key: ValueKey<bool>(checkBoxValue),
                      svgIcon: MyIcons.checkBoxTrue,
                      // iconColor: MyThemeColor.iconColor(context),
                    )
                  : Container(
                      height: 30.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: MyColors.secondaryBlue141F48,
                          )),
                    )
              // : SvgIconCustom(svgIcon: MyIcons.checkBoxFalse),
              ),
        ),
      ),
    );
  }
}
