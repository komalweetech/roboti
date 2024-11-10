import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/auth/view/widgets/auth_appbar.dart';
import 'package:roboti_app/presentation/auth/view/widgets/password_input_field.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_states.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  static const String route = "new_password";
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController? passwordController, confirmPasswordController;
  bool showPassword = false, showConfirmPassword = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController!.dispose();
    confirmPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordApiSuccessState) {
              context.pushNamedAndRemoveUntil(SignInScreen.route);
            }
          },
          builder: (context, state) => SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthAppbar(),
                TextView(
                  lc(context).enterYourNewPasswordToComplete,
                  style: myTextStyle.font_39wMedium,
                  padding: 20.paddingLeft(context),
                ),
                const Spacer(flex: 1),
                PasswordInputField(
                  hintText: lc(context).enterYourPassword,
                  obscure: showPassword,
                  onObscureTap: (val) {
                    setState(() => showPassword = !showPassword);
                  },
                  controller: passwordController,
                  onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
                ),
                PasswordInputField(
                  hintText: lc(context).retypeYourNewPassword,
                  obscure: showConfirmPassword,
                  onObscureTap: (val) {
                    setState(() => showConfirmPassword = !showConfirmPassword);
                  },
                  controller: confirmPasswordController,
                  onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
                ),
                14.vSpace(context),
                MyLoaderElvButton(
                  state: state,
                  text: lc(context).complete,
                  onPressed: () => authBloc.add(ResetPasswordApiEvent(
                    password: passwordController!.text,
                    confirmPassword: confirmPasswordController!.text,
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
}
