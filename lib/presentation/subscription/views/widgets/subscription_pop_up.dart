import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_elevated_button.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_plan.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/app_features_widget.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class SubscriptionPopUp extends StatelessWidget {
  const SubscriptionPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          subscriptionBloc.add(ShowSubcriptionPopupEvent(showPopup: false)),
      child: Container(
        height: 100.percentHeight(context),
        width: 100.percentWidth(context),
        padding: 20.paddingH(context),
        decoration: BoxDecoration(gradient: blueGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {},
              child: const AppFeaturesWidget(displaySubtitle: true),
            ),
            24.vSpace(context),
            MyElevatedButton(
              text: lc(context).upgradeToUnlock,
              onPressed: () =>
                  context.pushBTT(const SubscriptionPlan(), duration: 150),
              buttonBGColor: MyColors.green67FF66,
              textStyle: myTextStyle.font_20wMedium
                  .textColor(MyColors.primaryDarkBlue060A19),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient get blueGradient => LinearGradient(
        colors: [
          // MyColors.black0D0D0D,
          // MyColors.black0D0D0D,
          // MyColors.black0D0D0D,
          MyColors.black0D0D0D.withOpacity(0.9),
          MyColors.black0D0D0D.withOpacity(0.9),
          MyColors.black0D0D0D.withOpacity(0.85),
          MyColors.black0D0D0D.withOpacity(0.7),
          MyColors.black0D0D0D.withOpacity(0.15),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
