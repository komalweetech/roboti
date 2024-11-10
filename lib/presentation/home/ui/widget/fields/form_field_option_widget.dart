import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class OptionsTile extends StatelessWidget {
  final double height;
  final Function() onTap;
  final String text;
  const OptionsTile({
    super.key,
    required this.height,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 100.percentWidth(context),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            divider(context),
            const Spacer(),
            Padding(
              padding: 20.paddingH(context),
              child: Text(
                text,
                style: myTextStyle.font_16wRegular,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget divider(BuildContext context) {
    return Container(
      height: 1,
      width: 100.percentWidth(context),
      color: MyColors.lightBlue404C79,
      margin: 6.5.paddingH(context),
    );
  }
}
