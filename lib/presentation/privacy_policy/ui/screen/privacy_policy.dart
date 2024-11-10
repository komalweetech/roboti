import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/privacy_policy/data/policies_data.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  static const String route = "privacy_policy.dart";
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const MyLogoWidget(),
        leadingWidget: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actionWidgets: const [LocalizationButton()],
      ),
      body: Padding(
        padding: 20.paddingH(context).copyWith(
              top: 8.pxV(context),
              bottom: 8.pxV(context),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              lc(context).privacyPolicy,
              style: myTextStyle.font_25wRegular,
            ),
            10.vSpace(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  PoliciesData.policies,
                  style: myTextStyle.font_16wRegular,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
