import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/labelled_feature_widget.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class AppFeaturesWidget extends StatelessWidget {
  final bool displaySubtitle;
  const AppFeaturesWidget({
    super.key,
    this.displaySubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          "${lc(context).unlockUnlimitedAccess}!",
          style: myTextStyle.font_31BoldGreen,
        ),
        if (displaySubtitle)
          TextView(
            lc(context)
                .keepthemomentumgoingUnlockthefullpowerofRobotiforendlessbusinesssolutions,
            style: myTextStyle.font_16wRegular,
          ),
        13.8.vSpace(context),
        LablledFeatureWidget(
          iconPath: MyIcons.chatgptlogo,
          text: lc(context).poweredbyGPT,
        ),
        13.8.vSpace(context),
        LablledFeatureWidget(
          iconPath: MyIcons.editlogo,
          text: "40% ${lc(context).fasterPerformance}",
        ),
        13.8.vSpace(context),
        LablledFeatureWidget(
          iconPath: MyIcons.clocklogo,
          text: lc(context).extendedDialogueLimit,
        ),
        13.8.vSpace(context),
        LablledFeatureWidget(
          iconPath: MyIcons.alphabeticlogo,
          text: "90% ${lc(context).accurateinArabicEnglish}",
        ),
      ],
    );
  }
}
