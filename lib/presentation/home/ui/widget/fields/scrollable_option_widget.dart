import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/custom_badge.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/required_text_widget.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class HorizontalScrollableOptionsWIdget extends StatelessWidget {
  final List<Map<String, String>> children;
  final String title, key1, key2;
  final double? leftWidth;
  final Function(String) onTap;
  final EdgeInsets? padding;
  final EdgeInsets? titlePadding;
  final EdgeInsets badgePadding;
  final double? badgeWidth;
  final String selectedValue;
  final Color? shimmerColor;
  final bool showRequired;
  const HorizontalScrollableOptionsWIdget({
    super.key,
    required this.children,
    required this.title,
    required this.onTap,
    required this.key1,
    required this.key2,
    this.padding,
    this.titlePadding,
    required this.badgePadding,
    this.leftWidth,
    this.badgeWidth,
    required this.selectedValue,
    this.shimmerColor,
    required this.showRequired,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.percentWidth(context),
      child: Padding(
        padding: padding ?? 0.paddingAll(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextView(
                  title,
                  style: myTextStyle.font_16wRegular,
                  padding: titlePadding ?? 20.paddingH(context),
                ),
                if (showRequired) const FieldRequiredTextWidget(),
              ],
            ),
            11.vSpace(context),
            SizedBox(
              height: 38.pxV(context),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  if (leftWidth != null) leftWidth!.hSpace(context),
                  ...children.map(
                    (child) => CustomBadge(
                      badgePadding: badgePadding,
                      badgeWidth: badgeWidth,
                      child: child,
                      shimmerColor: shimmerColor,
                      selectedValue: selectedValue,
                      key1: key1,
                      key2: key2,
                      onTap: onTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
