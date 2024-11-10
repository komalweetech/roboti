import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/drawer_close_btn.dart';
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
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsModel news;
  final bool fromGlobal;
  const NewsDetailsScreen({
    super.key,
    required this.fromGlobal,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        addRepaintBoundaries: false,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 329.pxV(context),
                width: 120.percentWidth(context),
                child: NewsImageWidget(
                  news: news,
                  width: 120.percentWidth(context),
                  height: 329.pxV(context),
                  errprWidthPercentage: 50,
                ),
              ),
              Positioned(
                left: 20.pxH(context),
                top: 30.pxV(context),
                child: DrawerCloseButton(
                  onTap: () => context.pop(),
                  iconColor: MyColors.white,
                ),
              )
            ],
          ),
          19.2.vSpace(context),
          Padding(
            padding: isEng
                ? 20.paddingLeft(context).copyWith(right: 10.pxH(context))
                : 20.paddingRight(context).copyWith(left: 10.pxH(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.alarm,
                  size: 16.pxH(context),
                  color: MyColors.slateGrey676A88,
                ),
                10.3.hSpace(context),
                Text(
                  news.publishDate.toHHMMA(),
                  style: myTextStyle.font_12w400.copyWith(
                    height: 0,
                    color: MyColors.slateGrey676A88,
                  ),
                ),
                17.hSpace(context),
                Text(
                  news.publishDate.toDDMMMYYYY(),
                  style: myTextStyle.font_12w400.copyWith(
                    height: 0,
                    color: MyColors.slateGrey676A88,
                  ),
                ),
                const Spacer(),
                Transform.flip(
                  flipX: !isEng,
                  child: InkWell(
                    onTap: () async {
                      await ShareNews.share(fromGlobal);
                    },
                    splashColor: MyColors.blue374A91,
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.pxH(context),
                        vertical: 6.pxV(context),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            MyIcons.shareIcon,
                            color: MyColors.slateGrey676A88,
                            height: 16.pxV(context),
                          ),
                          TextView(
                            lc(context).share,
                            style: myTextStyle.font_16wRegular
                                .textColor(MyColors.slateGrey676A88),
                            padding: 7.paddingLeft(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (fromGlobal) ...[
            12.vSpace(context),
            TextView(
              '${lc(context).source}: ${news.sourceName}',
              padding: 21.paddingH(context),
              style: myTextStyle.font_16wRegular
                  .textColor(MyColors.slateGrey676A88),
              maxLine: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                21.hSpace(context),
                Text(
                  'URL:',
                  style: myTextStyle.font_16wRegular
                      .textColor(MyColors.slateGrey676A88),
                ),
                4.hSpace(context),
                GestureDetector(
                  onTap: () async => await launchUrl(
                    Uri.parse(news.sourceUrl!),
                  ),
                  child: Text(
                    news.sourceUrl!,
                    style: myTextStyle.font_16wRegular
                        .textColor(MyColors.slateGrey676A88)
                        .copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: MyColors.slateGrey676A88,
                        ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            12.vSpace(context),
          ] else
            25.vSpace(context),
          NewsTagWidget(
            news: news,
            padding: 21.paddingH(context),
          ),
          TextView(
            isEng ? news.title : news.translatedTitle,
            padding: 21.paddingH(context).copyWith(top: 4.pxV(context)),
            style: myTextStyle.font_20wMedium.copyWith(
              color: MyColors.softPinkFD6AF5,
              height: 0,
            ),
            width: 100.percentWidth(context),
          ),
          25.vSpace(context),
          if (fromGlobal)
            TextView(
              isEng ? news.content : news.translatedContent,
              padding: 21.paddingH(context),
              style: myTextStyle.font_16wRegular,
            )
          else
            Padding(
              padding: 21.paddingH(context),
              child: HtmlWidget(
                isEng ? news.description : news.translatedDescription,
                textStyle: const TextStyle(color: MyColors.whiteFFFFFF),
              ),
            ),
        ],
      ),
    );
  }
}
