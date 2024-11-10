import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/my_text_field.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/otp_screen.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_states.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = "forgot_password";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool showPassword = false;

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
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const MyAppBar(
          leadingWidget: MyBackButton(),
          title: MyLogoWidget(),
          actionWidgets: [LocalizationButton(showName: true)],
        ),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ForgotPasswordOtpSuccessState) {
              gotoOtpScreen(context, state);
            }
          },
          builder: (context, state) => SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  lc(context).forgotPassword,
                  style: myTextStyle.font_39wMedium,
                  padding: 20.paddingH(context),
                ),
                TextView(
                  lc(context).enterYourEmailToResetYourPassword,
                  style: myTextStyle.font_20wMedium.regular,
                  padding: 20.paddingH(context),
                ),
                const Spacer(flex: 1),
                MyTextFormField(
                  margin: 16.paddingH(context),
                  hintText: lc(context).emailAddress,
                  bottomSpace: 16,
                  controller: controller,
                  prefixIconPath: MyIcons.emailMessage,
                ),
                14.vSpace(context),
                MyLoaderElvButton(
                  state: state,
                  text: lc(context).next,
                  onPressed: () => authBloc.add(ForgotPasswordEmailAddedEvent(
                    email: controller!.text,
                  )),
                  padding: 16.paddingH(context),
                  textStyle: myTextStyle.font_20wMedium,
                ),
                const Spacer(flex: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void gotoOtpScreen(BuildContext context, AuthState state) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const OtpScreen(fromPassword: true),
      ),
    );
  }
}
