import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/forgot_password_screen.dart';
import 'package:roboti_app/presentation/auth/view/screens/otp_screen.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_up.dart';
import 'package:roboti_app/presentation/auth/view/widgets/auth_appbar.dart';
import 'package:roboti_app/presentation/auth/view/widgets/password_input_field.dart';
import 'package:roboti_app/presentation/auth/view/widgets/social_login_button.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_states.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_states.dart';
import 'package:roboti_app/presentation/base_screen/ui/screen/base_screen.dart';
import 'package:roboti_app/presentation/getting_started/ui/widget/divider_with_text_widget.dart';
import 'package:roboti_app/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:roboti_app/presentation/terms_and_condition/ui/screen/terms_and_condition.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import '../../../../common/widget/my_text_field.dart';

class SignInScreen extends StatefulWidget {
  static const String route = "sign_in";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showPassword = false;
  TextEditingController? emailController, passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    if (authBloc.state is ResetPasswordApiSuccessState) {
      emailController!.text = authBloc.user.email;
    }
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is LoginButtonPressSuccessState ||
                  state is GoogleLoginSuccessState) {
                context.pushNamedAndRemoveUntil(BaseScreen.route);
              } else if (state is OtpNotVerifiedState) {
                context.pushNamed(OtpScreen.route);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthAppbar(isLogin: true),
                  TextView(
                    lc(context).welcome,
                    style: myTextStyle.font_48wMedium,
                    padding: 20.paddingH(context),
                  ),
                  TextView(
                    lc(context).signInToContinue,
                    style: myTextStyle.font_25wRegular,
                    padding: 20.paddingH(context),
                  ),
                  // 47.vSpace(context),
                  const Spacer(flex: 2),
                  MyTextFormField(
                    hintText: lc(context).emailAddress,
                    bottomSpace: 16,
                    prefixIconPath: MyIcons.emailMessage,
                    margin: 20.paddingH(context),
                    controller: emailController,
                  ),
                  PasswordInputField(
                    hintText: lc(context).enterYourPassword,
                    obscure: showPassword,
                    onObscureTap: (val) {
                      setState(() => showPassword = !showPassword);
                    },
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).nextFocus(),
                    controller: passwordController,
                  ),
                  MyLoaderElvButton(
                    state: state,
                    text: lc(context).login,
                    onPressed: () {
                      primaryFocus!.unfocus();
                      authBloc.add(LoginButtonPressEvent(
                        email: emailController!.text,
                        password: passwordController!.text,
                      ));
                      // context.pushReplacementNamed(BaseScreen.route);
                    },
                    textStyle:
                        myTextStyle.font_20wMedium.copyWith(fontSize: 18),
                    padding: 20.paddingH(context),
                  ),
                  8.vSpace(context),
                  TextView(
                    lc(context).byContininingWithThisApp,
                    style: myTextStyle.font_12w400.copyWith(
                      color: MyColors.black7B8598,
                    ),
                    padding: 20.paddingH(context),
                  ),
                  MyRichText(
                    text1: lc(context).youAcceptOur,
                    text2: lc(context).termsOfUse,
                    onTap2: () {
                      context.pushNamed(TermsAndConditionScreen.route);
                    },
                    text3: lc(context).andOur,
                    text4: lc(context).privacyPolicy,
                    onTap4: () {
                      context.pushNamed(PrivacyPolicyScreen.route);
                    },
                    text5: lc(context).here,
                    style1: myTextStyle.font_12w400.copyWith(
                      color: MyColors.black7B8598,
                    ),
                    style2: myTextStyle.font_12w400.copyWith(
                      color: MyColors.blue2575FC,
                      decoration: TextDecoration.underline,
                    ),
                    style4: myTextStyle.font_12w400.copyWith(
                      color: MyColors.blue2575FC,
                      decoration: TextDecoration.underline,
                    ),
                    margin: 20.paddingH(context),
                  ),
                  const Spacer(flex: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        lc(context).notRegistered,
                        style: myTextStyle.font_16wRegular.copyWith(
                          color: MyColors.black7B8598,
                        ),
                      ),
                      TextView(
                        lc(context).createNewAccount,
                        style: myTextStyle.font_16wRegular.copyWith(
                          color: MyColors.indigo3958ED,
                          fontWeight: FontWeight.bold,
                        ),
                        onTap: () => context.pushNamed(SignUpScreen.route),
                        padding: 5.paddingAll(context),
                      ),
                    ],
                  ),
                  21.vSpace(context),
                  DividerWithText(
                    margin: 20.paddingH(context),
                    style: myTextStyle.font_16wRegular.copyWith(
                      color: MyColors.black7B8598,
                    ),
                    text: lc(context).continueWith,
                  ),
                  18.vSpace(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialLoginButton(
                        percentWidth: Platform.isAndroid ? 90 : 42.55,
                        onTap: () => authBloc.add(GoogleLoginEvent()),
                        icon: SvgPicture.asset(MyIcons.googleIcon),
                      ),
                      if (Platform.isIOS)
                        SocialLoginButton(
                          onTap: () => authBloc.add(AppleLoginEvent()),
                          icon: Image.asset(MyIcons.appleIconPng),
                        ),
                    ],
                  ),

                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: TextView(
                      lc(context).forgetYourPassword,
                      style: myTextStyle.font_16wRegular.copyWith(
                        color: MyColors.black7B8598,
                      ),
                      textAlign: TextAlign.center,
                      padding: 8.paddingAll(context),
                      onTap: () =>
                          context.pushNamed(ForgotPasswordScreen.route),
                    ),
                  ),

                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
