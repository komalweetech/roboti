import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class CategoryImageWidget extends StatelessWidget {
  final String url;
  final String name;
  const CategoryImageWidget({
    super.key,
    required this.url,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    // print(url);
    // return defaultImage(context);
    return Container(
      height: 44.pxV(context),
      width: 44.pxH(context),
      child: url.isEmpty
          ? defaultImage(context)
          : SvgPicture.network(
              url,
              semanticsLabel: name.toUpperCase(),
              placeholderBuilder: (context) => progressWidget(),
            ),
    );

    // url.isEmpty
    //     ? defaultImage(context)
    //     // : SvgPicture.network(
    //     //     url,
    //     //   );
    //     : CachedNetworkImage(
    //         imageUrl: url,
    //         progressIndicatorBuilder: (context, a, b) => progressWidget(),
    //         height: 44.pxV(context),
    //         width: 44.pxH(context),
    //         errorWidget: (context, url, obj) => defaultImage(context),
    //         imageBuilder: (context, imageProvider) => SvgPicture.network(
    //           url,
    //           placeholderBuilder: (BuildContext context) => progressWidget(),
    //         ),
    //       );
  }

  Widget progressWidget() {
    return const CupertinoActivityIndicator();
    // return Container(
    //   height: 20,
    //   width: 20,
    //   color: Colors.amber,
    // );
  }

  Widget defaultImage(BuildContext context) {
    return SvgPicture.asset(
      MyImages.tempSvg,
      height: 44.pxV(context),
      width: 44.pxH(context),
    );
  }
}
