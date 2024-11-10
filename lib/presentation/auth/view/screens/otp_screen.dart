import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/create_new_password.dart';
import 'package:roboti_app/presentation/auth/view/widgets/auth_appbar.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_states.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_states.dart';
import 'package:roboti_app/presentation/base_screen/ui/screen/base_screen.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class OtpScreen extends StatefulWidget {
  static const String route = "otp_screen";
  final bool fromPassword;
  const OtpScreen({
    super.key,
    this.fromPassword = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool showPassword = false;
  String otp = "";

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
              if (state is VerifyOtpSuccessState) {
                context.pushNamedAndRemoveUntil(BaseScreen.route);
              } else if (state is ForgotPasswordOtpVerificationSuccessState) {
                context.pushNamedAndRemoveUntil(CreateNewPasswordScreen.route);
              }
            },
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthAppbar(),
                TextView(
                  lc(context).enterOtpCode,
                  style: myTextStyle.font_39wMedium,
                  padding: 20.paddingH(context),
                ),
                MyRichText(
                  text1: lc(context).weSentYouYourOtpToYourEmailAddress,
                  text2: authBloc.user.email,
                  style1: myTextStyle.font_20wMedium.regular.copyWith(
                    color: MyColors.whiteFFFFFF,
                  ),
                  style2: myTextStyle.font_20wMedium.regular.copyWith(
                    color: MyColors.blue2575FC,
                    // decoration: TextDecoration.underline,
                  ),
                  margin: 20.paddingH(context),
                ),
                const Spacer(),
                Padding(
                  padding: 20.paddingH(context),
                  child: PinCodeTextField(
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      activeColor: MyColors.pinFieldBlue141F48,
                      selectedColor: MyColors.pinFieldBlue141F48,
                      inactiveColor: MyColors.pinFieldBlue141F48,
                      disabledColor: MyColors.pinFieldBlue141F48,
                      activeFillColor: MyColors.pinFieldBlue141F48,
                      selectedFillColor: MyColors.pinFieldBlue141F48,
                      inactiveFillColor: MyColors.pinFieldBlue141F48,
                      fieldHeight: 70.pxV(context),
                      fieldWidth: 70.pxH(context),
                      borderWidth: 0,
                      activeBorderWidth: 0,
                      inactiveBorderWidth: 0,
                      disabledBorderWidth: 0,
                      selectedBorderWidth: 0,
                      borderRadius: BorderRadius.circular(10.pxV(context)),
                    ),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    animationCurve: Curves.fastEaseInToSlowEaseOut,
                    textStyle: myTextStyle.font_20wMedium,
                    appContext: context,
                    onCompleted: (value) async {
                      otp = value;
                      if (widget.fromPassword) {
                        authBloc.add(ForgotPasswordOtpEvent(otp: otp));
                      } else {
                        authBloc.add(SignupOtpEvent(otp: otp));
                      }
                    },
                    length: 5,
                    blinkDuration: const Duration(milliseconds: 100),
                    animationDuration: Duration.zero,
                  ),
                ),
                4.vSpace(context),
                MyLoaderElvButton(
                  state: state,
                  text: lc(context).next,
                  onPressed: () {
                    if (widget.fromPassword) {
                      authBloc.add(ForgotPasswordOtpEvent(otp: otp));
                    } else {
                      authBloc.add(SignupOtpEvent(otp: otp));
                    }
                  },
                  padding: 16.paddingH(context),
                  textStyle: myTextStyle.font_20wMedium,
                ),
                36.vSpace(context),
                TextView(
                  lc(context).didntReceivedCodeYet,
                  style: myTextStyle.font_16wRegular
                      .textColor(MyColors.white788598),
                  padding: 20.paddingH(context),
                  alignment: Alignment.center,
                ),
                TextView(
                  lc(context).resendTheCode,
                  style: myTextStyle.font_16wRegular.bold
                      .textColor(MyColors.indigo3958ED),
                  padding: 20.paddingH(context),
                  alignment: Alignment.center,
                  onTap: () {
                    authBloc.add(ResendOtpEvent.fromUser(authBloc.user));
                  },
                  overlayColor: MaterialStateProperty.all(MyColors.transparent),
                ),
                const Spacer(flex: 9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
