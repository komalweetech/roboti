import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.icon,
      required this.subTitle,
      required this.title,
      required this.onTap});

  final String title;
  final String subTitle;
  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: 24.paddingH(context),
          leading: SvgPicture.asset(
            icon,
            width: 24.pxH(context),
            height: 24.pxH(context),
          ),
          title: Text(
            title,
            style: myTextStyle.font_20wMedium.regular
                .textColor(MyColors.whiteFFFFFF),
            // style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          horizontalTitleGap: 14.pxH(context),
          subtitle: Text(
            subTitle,
            style: myTextStyle.font_12w500.textColor(MyColors.white585f78),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20.pxV(context),
          ),
          onTap: onTap,
        ),
        Container(
          height: 1,
          width: 100.percentWidth(context),
          margin: 17.paddingRight(context),
          color: MyColors.pinFieldBlue141F48,
        ),
      ],
    );
  }
}
