import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class CustomBadge extends StatelessWidget {
  final double? badgeWidth;
  final EdgeInsets badgePadding;
  final String selectedValue;
  final Map<String, String> child;
  final String key1, key2;
  final Function(String) onTap;
  final Color? shimmerColor;
  const CustomBadge({
    super.key,
    required this.badgeWidth,
    required this.badgePadding,
    required this.selectedValue,
    required this.child,
    required this.key1,
    required this.key2,
    required this.onTap,
    this.shimmerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: badgeWidth,
      margin: 5.paddingRight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.pxV(context)),
        color: shimmerColor ??
            (selectedValue == child[key2].toString()
                ? MyColors.blue2A2D9E
                : MyColors.grey181924),
      ),
      child: InkWell(
        onTap: () => onTap(child[key2].toString()),
        borderRadius: BorderRadius.circular(8.pxV(context)),
        child: Padding(
          padding: badgePadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (badgeWidth != null) const Spacer(),
              SizedBox(
                height: 16.pxV(context),
                child: Text(
                  child[key1].toString(),
                  style: TextStyle(
                    height: 1,
                    fontSize: 16.pxV(context),
                  ),
                ),
              ),
              2.hSpace(context),
              Text(
                child[key2].toString(),
                style: myTextStyle.font_16wRegular.copyWith(height: 1),
              ),
              if (badgeWidth != null) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
