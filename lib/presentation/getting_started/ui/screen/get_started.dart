import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_outline_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/getting_started/ui/widget/divider_with_text_widget.dart';
import 'package:roboti_app/presentation/getting_started/ui/widget/instructions_widget.dart';
import 'package:roboti_app/presentation/auth/view/widgets/text_button_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class GetStartedScreen extends StatefulWidget {
  static const String route = "get_started_screen";
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              65.vSpace(context),
              TextView(
                lc(context).gettingStarted,
                padding: 21.paddingLeft(context),
                style: myTextStyle.font_32w700,
              ),
              TextView(
                lc(context).createAccountToContinue,
                padding: 21.paddingLeft(context),
                style: myTextStyle.font_13w300,
              ),
              const Spacer(flex: 3),
              MyOutlineButton(
                iconSpacing: 33.pxH(context),
                prefixIcon: SvgPicture.asset(MyIcons.googleIcon),
                text: lc(context).signUpWithGoogle,
                onPressed: () {},
                padding: 42.paddingH(context),
              ),
              16.vSpace(context),
              DividerWithText(
                style: myTextStyle.font_13w700
                    .copyWith(color: MyColors.black0D0D0D),
                text: lc(context).or,
              ),
              16.vSpace(context),
              MyOutlineButton(
                iconSpacing: 33.pxH(context),
                prefixIcon: SvgPicture.asset(MyIcons.mailIcon),
                text: lc(context).signUpWithGoogle,
                onPressed: () {},
                padding: 42.paddingH(context),
              ),
              31.vSpace(context),
              TextButtonRow(
                buttonText: lc(context).signIn,
                message: lc(context).alreadyHaveAnAccount,
                onTap: () {
                  context.pushNamed(SignInScreen.route);
                },
              ),
              8.vSpace(context),
              InstructionWidget(
                onPrivacyPolicyTap: () {},
                onTermsAndPoliciesTap: () {},
              ),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
