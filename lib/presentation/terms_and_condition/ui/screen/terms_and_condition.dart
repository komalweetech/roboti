import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/terms_and_condition/data/terms_and_condition_data.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class TermsAndConditionScreen extends StatefulWidget {
  static const String route = "terms_and_condition.dart";
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const MyLogoWidget(),
        leadingWidget: IconButton(
            onPressed: () {
              context.pop();
            },
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
              lc(context).termsAndConditions,
              style: myTextStyle.font_25wRegular,
            ),
            10.vSpace(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  TermsAndConditionsData.getData,
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
