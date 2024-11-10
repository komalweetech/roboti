import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class NewsImageWidget extends StatelessWidget {
  final NewsModel news;
  final double height, width;
  final BoxFit fit;
  final double errprWidthPercentage;
  const NewsImageWidget({
    super.key,
    required this.news,
    this.height = 95.37,
    this.width = 95.37,
    this.errprWidthPercentage = 100,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.pxH(context),
      width: width.pxH(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.pxV(context)),
        color: news.isSvg == null ? MyColors.blue23326A : Colors.transparent,
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.pxV(context)),
        child: news.isSvg == null
            ? Text(
                lc(context).coverImage,
                style: myTextStyle.font_12w400.textColor(MyColors.white788598),
              )
            : news.isSvg!
                ? SvgPicture.network(
                    news.imageUrl,
                    fit: fit,
                    height: height.pxH(context),
                    width: width.pxH(context),
                  )
                : CachedNetworkImage(
                    imageUrl: news.imageUrl,
                    fit: fit,
                    height: height.pxH(context),
                    width: width.pxH(context),
                    errorWidget: (context, url, error) => Image.asset(
                      MyIcons.robotiIconPNG,
                      width: (errorWidth()).pxH(context),
                    ),
                  ),
      ),
    );
  }

  double errorWidth() {
    double errorwidth = width * (errprWidthPercentage / 100);

    return errorwidth;
  }
}
