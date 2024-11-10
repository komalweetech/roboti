import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:roboti_app/presentation/terms_and_condition/ui/screen/terms_and_condition.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class SubscriptionBottomWidget extends StatelessWidget {
  const SubscriptionBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(TermsAndConditionScreen.route);
          },
          child: TextView(
            lc(context).terms,
            style: myTextStyle.font_16wRegular.textColor(MyColors.grey74747B),
          ),
        ),
        const Text(
          ".",
          style: TextStyle(color: MyColors.grey74747B),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(PrivacyPolicyScreen.route);
          },
          child: TextView(
            lc(context).privacyPolicy,
            style: myTextStyle.font_16wRegular.textColor(MyColors.grey74747B),
          ),
        ),
        const Text(
          ".",
          style: TextStyle(color: MyColors.grey74747B),
        ),
        GestureDetector(
          onTap: () {
            Purchases.restorePurchases();
          },
          child: TextView(
            lc(context).restore,
            style: myTextStyle.font_16wRegular.textColor(MyColors.grey74747B),
          ),
        ),
      ],
    );
  }
}
