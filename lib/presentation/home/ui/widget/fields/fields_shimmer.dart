import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/scrollable_option_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FiledScreenShimmer extends StatelessWidget {
  const FiledScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: MyColors.containerShimmerColor,
        highlightColor: Colors.white.withOpacity(0.3),
        duration: const Duration(milliseconds: 800),
      ),
      child: Padding(
        padding: 20.paddingH(context).copyWith(bottom: 16.pxV(context)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            2.vSpace(context),
            const TextView(
              "Text         Text",
            ),
            const TextView(
              "Text         Text",
            ),
            20.vSpace(context),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.pxV(context))),
              child: Container(
                width: 100,
                height: 76.pxV(context),
                color: MyColors.containerShimmerColor,
              ),
            ),
            16.vSpace(context),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.pxV(context))),
              child: Container(
                width: 100,
                height: 76.pxV(context),
                color: MyColors.containerShimmerColor,
              ),
            ),
            16.vSpace(context),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.pxV(context))),
              child: Container(
                width: 100,
                height: 160.pxV(context),
                color: MyColors.containerShimmerColor,
              ),
            ),
            16.vSpace(context),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.pxV(context))),
              child: Container(
                width: 100,
                height: 76.pxV(context),
                color: MyColors.containerShimmerColor,
              ),
            ),
            67.vSpace(context),
            HorizontalScrollableOptionsWIdget(
              title: "Select tone of voice",
              titlePadding: 0.paddingLeft(context),
              selectedValue: homeBloc.tone,
              badgePadding: EdgeInsets.only(
                top: 8.pxV(context),
                left: 16.pxH(context),
                bottom: 9.pxV(context),
                right: 16.pxH(context),
              ),
              leftWidth: 0,
              shimmerColor: MyColors.containerShimmerColor,
              children: const [
                {'img': "🙂", "text": "Normal"},
                {'img': "😍", "text": "Friendly"},
                {'img': "❤️", "text": "Lovely"},
                {'img': "😞", "text": "Sad"},
                {'img': "👨", "text": "Formal"},
                {'img': "😡", "text": "Angry"},
                {'img': "😊", "text": "Happy"},
              ],
              onTap: (val) {},
              key1: "img",
              key2: "text",
              showRequired: false,
            ),
            16.vSpace(context),
            HorizontalScrollableOptionsWIdget(
              title: "Select tone of voice",
              titlePadding: 0.paddingLeft(context),
              selectedValue: homeBloc.tone,
              badgePadding: EdgeInsets.only(
                top: 8.pxV(context),
                left: 16.pxH(context),
                bottom: 9.pxV(context),
                right: 16.pxH(context),
              ),
              leftWidth: 0,
              shimmerColor: MyColors.containerShimmerColor,
              children: const [
                {'img': "🙂", "text": "Normal"},
                {'img': "😍", "text": "Friendly"},
                {'img': "❤️", "text": "Lovely"},
                {'img': "😞", "text": "Sad"},
                {'img': "👨", "text": "Formal"},
                {'img': "😡", "text": "Angry"},
                {'img': "😊", "text": "Happy"},
              ],
              onTap: (val) {},
              key1: "img",
              key2: "text",
              showRequired: false,
            ),
            10.percentHeight(context).vSpace(context),
          ],
        ),
      ),
    );
  }
}
