import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class NewsTagWidget extends StatelessWidget {
  final NewsModel news;
  final double horizontalPadding;
  final EdgeInsets? padding;
  final double iconSize, separationSpace, fontSize;
  const NewsTagWidget({
    super.key,
    required this.news,
    this.horizontalPadding = 24,
    this.padding,
    this.iconSize = 12,
    this.separationSpace = 6,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? horizontalPadding.paddingH(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // News image, NEws heading and tags
          SvgPicture.asset(
            MyIcons.newsComponentIcon,
            height: iconSize.pxH(context),
            width: iconSize.pxH(context),
          ),

          separationSpace.hSpace(context),

          TextView(
            isEng ? news.type : news.translatedType,
            style: myTextStyle.font_12w400.copyWith(
              color: MyColors.softPinkFD6AF5,
              fontSize: fontSize.pxV(context),
              height: 0,
            ),
          ),

          if (news.tags?.isNotEmpty ?? false) ...[
            12.hSpace(context),
            Text(
              news.tags!,
              style: myTextStyle.font_12w400.copyWith(
                height: 0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
