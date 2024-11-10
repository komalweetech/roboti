import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/my_check_box.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/otp_screen.dart';
import 'package:roboti_app/presentation/auth/view/widgets/select_country_field.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_states.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:roboti_app/presentation/terms_and_condition/ui/screen/terms_and_condition.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class SelectCountryScreen extends StatefulWidget {
  static const String route = "select_country";
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  bool isAgree = false;
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: MyLogoWidget(),
        leadingWidget: MyBackButton(),
        actionWidgets: [LocalizationButton(showName: true)],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is CreateAccountApiSuccessState) {
            context.pushNamed(OtpScreen.route);
          } else if (state is CountrySelectedState) {
            controller!.text = authBloc.user.countryName;
          }
          //   },
        },
        builder: (context, state) => Column(
          children: [
            TextView(
              lc(context).lastStepToCompleteYourAccount,
              style: myTextStyle.font_39wMedium,
              padding: 20.paddingH(context),
            ),
            34.vSpace(context),
            ChooseCountryWidget(
              controller: controller!,
              onSelected: (country) =>
                  authBloc.add(CountrySelectedEvent(country: country)),
            ),
            19.vSpace(context),
            Padding(
              padding: 20.paddingH(context),
              child: Row(
                children: [
                  MyCheckBoxFilter(
                    checkBoxValue: isAgree,
                    onPressed: () {
                      setState(() {
                        isAgree = !isAgree;
                      });
                    },
                  ),
                  10.hSpace(context),
                  Expanded(
                    child: Wrap(
                      children: [
                        MyRichText(
                          text1: "${lc(context).iAgreeToThe} ",
                          text2: lc(context).termsAndConditions,
                          onTap2: () =>
                              context.pushNamed(TermsAndConditionScreen.route),
                          text3: lc(context).and,
                          text4: lc(context).privacyPolicy,
                          onTap4: () =>
                              context.pushNamed(PrivacyPolicyScreen.route),
                          style1: myTextStyle.font_16wRegular
                              .textColor(MyColors.white788598),
                          style2: myTextStyle.font_16wRegular.copyWith(
                            color: MyColors.blue0351FF,
                            decoration: TextDecoration.underline,
                          ),
                          style3: myTextStyle.font_16wRegular.textColor(
                            MyColors.white788598,
                          ),
                          style4: myTextStyle.font_16wRegular.copyWith(
                            color: MyColors.blue0351FF,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            47.vSpace(context),
            MyLoaderElvButton(
              state: state,
              text: lc(context).continueText,
              // onPressed: () => context.pushNamed(OtpScreen.route),
              onPressed: () {
                if (isAgree) {
                  authBloc.add(CreateAccountApiEvent());
                } else {
                  MySnackbar.showSnackbar(lc(context).pleaseAgreePrivacy);
                }
              },
              padding: 20.paddingH(context),
              textStyle: myTextStyle.font_20wMedium,
            ),
          ],
        ),
      ),
    );
  }
}
