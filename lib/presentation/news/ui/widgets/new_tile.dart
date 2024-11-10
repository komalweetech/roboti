import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/presentation/news/ui/widgets/news_image_widget.dart';
import 'package:roboti_app/presentation/news/ui/widgets/news_tag_widget.dart';
import 'package:roboti_app/presentation/news/view_model/repo/share_news_repo.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/date_time.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class NewsTile extends StatelessWidget {
  final NewsModel news;
  final bool fromGlobal;
  final Function() onTap;
  const NewsTile({
    super.key,
    required this.news,
    required this.onTap,
    required this.fromGlobal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            children: [
              11.vSpace(context),
              NewsTagWidget(news: news),
              13.2.vSpace(context),
              Padding(
                padding: 20.paddingH(context),
                child: Row(
                  children: [
                    // News info
                    NewsImageWidget(news: news),
                    13.9.hSpace(context),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          isEng ? news.title : news.translatedTitle,
                          style: myTextStyle.font_20wMedium.regular,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          width: 65.percentWidth(context),
                        ),
                        if (fromGlobal) ...[
                          8.vSpace(context),
                          TextView(
                            '${lc(context).source}: ${news.sourceName}',
                            style: myTextStyle.font_12w400.copyWith(height: 0),
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            width: 65.percentWidth(context),
                          ),
                          12.vSpace(context),
                        ] else
                          26.vSpace(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 11.4.pxH(context),
                              color: MyColors.whiteFFFFFF,
                            ),
                            10.3.hSpace(context),
                            Text(
                              news.publishDate.toHHMMA(),
                              style:
                                  myTextStyle.font_12w400.copyWith(height: 0),
                            ),
                            17.hSpace(context),
                            Text(
                              news.publishDate.toDDMMMYYYY(),
                              style:
                                  myTextStyle.font_12w400.copyWith(height: 0),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Divider
              13.6.vSpace(context),
              Container(
                height: 1,
                width: 100.percentWidth(context),
                color: MyColors.grey252736,
              ),
            ],
          ),
          Positioned(
            right: isEng ? 10.5.pxH(context) : null,
            left: !isEng ? 10.5.pxH(context) : null,
            child: Transform.flip(
              flipX: !isEng,
              child: InkWell(
                onTap: () async => await ShareNews.share(fromGlobal),
                splashColor: MyColors.blue374A91,
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.pxH(context),
                    vertical: 6.pxV(context),
                  ),
                  child: SvgPicture.asset(
                    MyIcons.shareIcon,
                    color: MyColors.whiteFFFFFF,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
