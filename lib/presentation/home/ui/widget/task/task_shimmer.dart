import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TaskScreenLoadingShimmer extends StatelessWidget {
  const TaskScreenLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 48.paddingTop(context),
      child: Skeletonizer(
          effect: ShimmerEffect(
            baseColor: MyColors.containerShimmerColor,
            highlightColor: Colors.white.withOpacity(0.3),
            duration: const Duration(milliseconds: 800),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: 100.percentWidth(context),
                margin: 20.paddingH(context).copyWith(bottom: 8.pxV(context)),
                decoration: BoxDecoration(
                  color: MyColors.containerShimmerColor,
                  borderRadius: BorderRadius.circular(16.pxH(context)),
                ),
                child: Padding(
                  padding: 35.1.paddingH(context).copyWith(top: 18, bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 33.47.pxH(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 33.47.pxH(context),
                              width: 33.47.pxH(context),
                              color: MyColors.containerShimmerColor,
                            ),
                          ],
                        ),
                      ),
                      17.4.hSpace(context),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextView(
                              "task.title",
                            ),
                            3.vSpace(context),
                            const Text(
                              "task.description",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
