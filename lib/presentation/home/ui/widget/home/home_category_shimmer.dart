import 'package:roboti_app/common/widget/text_view.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCategoryScreenLoadingShimmer extends StatelessWidget {
  const HomeCategoryScreenLoadingShimmer({
    super.key,
    required this.data,
  });

  final List<Widget> data;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: MyColors.containerShimmerColor,
        highlightColor: Colors.white.withOpacity(0.3),
        duration: const Duration(milliseconds: 800),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          24.vSpace(context),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.pxV(context)),
            child: Container(
              height: 180.55.pxV(context),
              width: 90.percentWidth(context),
              color: MyColors.containerShimmerColor,
            ),
          ),
          16.vSpace(context),
          Container(
            padding: 7.6.paddingV(context).copyWith(
                  left: 11.pxH(context),
                  right: 11.pxH(context),
                ),
            margin: 20.paddingH(context),
            width: 100.percentWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.pxV(context)),
              color: MyColors.containerShimmerColor,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.pxV(context)),
                  child: Container(
                    height: 60.8.pxH(context),
                    width: 60.8.pxH(context),
                    color: MyColors.containerShimmerColor,
                  ),
                ),
                13.2.hSpace(context),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        "T                  T                 T       T",
                      ),
                      4.vSpace(context),
                      const TextView(
                        "T                  T                 T",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.vSpace(context),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: 4.65.percentWidth(context)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 20.percentHeight(context),
                mainAxisSpacing: 1.604.percentHeight(context),
                crossAxisSpacing: 3.72.percentWidth(context),
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  height: 20.percentHeight(context),
                  width: 43.48.percentWidth(context),
                  decoration: BoxDecoration(
                    color: MyColors.containerShimmerColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: 25.paddingAll(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 44.pxV(context),
                        width: 44.pxH(context),
                        color: MyColors.blue374A91,
                      ),
                      4.9.vSpace(context),
                      FittedBox(
                        child: TextView(
                          "category.title",
                          style: myTextStyle.font_25wRegular,
                          maxLine: 1,
                        ),
                      ),
                      15.vSpace(context),
                      Expanded(
                        child: TextView(
                          "category.description category.description category.description",
                          style: myTextStyle.font_25wRegular.copyWith(
                            fontSize: 12.4.pxV(context),
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
