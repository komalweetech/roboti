import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class ContactUsListTile extends StatelessWidget {
  const ContactUsListTile({
    required this.heading,
    required this.value,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String heading;
  final String value;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      margin: 8.paddingBottom(context),
      padding: 12.paddingAll(context),
      decoration: BoxDecoration(
        color: MyColors.grey161A27,
        borderRadius: BorderRadius.circular(10.pxH(context)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: MyColors.grey74747B,
              size: 32,
            ),
            12.hSpace(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  heading,
                  style: myTextStyle.font_16wRegular.copyWith(fontSize: 18),
                ),
                4.vSpace(context),
                TextView(
                  value,
                  style: myTextStyle.font_16wRegular
                      .textColor(MyColors.grey74747B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
