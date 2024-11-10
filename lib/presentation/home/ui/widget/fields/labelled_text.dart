import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class LabeledText extends StatelessWidget {
  final Function() onTap;
  final String icon, text;
  final Color textColor;
  const LabeledText({
    super.key,
    required this.icon,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      overlayColor: MaterialStateProperty.all(MyColors.secondaryBlue141F48),
      child: Container(
        padding:
            4.paddingAll(context).copyWith(right: isEng ? 0 : 4.pxH(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              icon,
              width: 17.pxH(context),
            ),
            TextView(
              text,
              style: myTextStyle.font_16wRegular
                  .copyWith(height: 1, color: textColor),
              padding: 7
                  .paddingLeft(context)
                  .copyWith(right: isEng ? 0 : 7.pxH(context)),
            ),
          ],
        ),
      ),
    );
  }
}
