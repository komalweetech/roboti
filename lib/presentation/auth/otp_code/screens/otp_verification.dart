import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class OTPVerificationScreen extends StatefulWidget {
  static const String route = "otp_verification";
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<OTPVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        primaryFocus!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.vSpace(context),
                // const RobotiFlagAppbar(),
                20.vSpace(context),
                TextView(
                  lc(context).enterOtpCode,
                  style: myTextStyle.font_48wMedium,
                ),
                MyRichText(
                  text1: lc(context).weSentYouYourOtpToYourEmailAddress,
                  text2: 'ahmed@mindminse.co',
                  style1: myTextStyle.font_20wMedium.copyWith(
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                  style2: myTextStyle.font_20wMedium.copyWith(
                    color: MyColors.indigo3958ED,
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
                40.vSpace(context),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: TextView(
                      lc(context).resendTheCode,
                      style: myTextStyle.font_16wRegular.copyWith(
                        color: MyColors.indigo3958ED,
                        fontWeight: FontWeight.bold,
                      ),
                      overlayColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
