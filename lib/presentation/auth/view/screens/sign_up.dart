import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_elevated_button.dart';
import 'package:roboti_app/common/widget/my_text_field.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/view/screens/select_country_screen.dart';
import 'package:roboti_app/presentation/auth/view/widgets/password_input_field.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_states.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = "sign_up";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false, showConfirmPassword = false;
  TextEditingController? fNameController,
      // lNameController,
      emailController,
      passwordController,
      confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    fNameController = TextEditingController();
    // lNameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    fNameController!.dispose();
    // lNameController!.dispose();
    confirmPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MyAppBar(
          title: MyLogoWidget(),
          leadingWidget: MyBackButton(),
          actionWidgets: [LocalizationButton(showName: true)],
        ),
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is CreateNewAccountState) {
                // authBloc.add(SignupOtpEvent.from(state));
                context.push(SelectCountryScreen.route);
              }
            },
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const AuthAppbar(),
                TextView(
                  lc(context).createNewAccount,
                  style: myTextStyle.font_39wMedium,
                  padding: 20.paddingH(context),
                ),
                const Spacer(flex: 1),
                MyTextFormField(
                  margin: 20.paddingH(context),
                  hintText: lc(context).yourFullName,
                  bottomSpace: 16,
                  prefixIconPath: MyIcons.profileCircleIcon,
                  controller: fNameController,
                  textCapitalization: TextCapitalization.words,
                ),
                // MyTextFormField(
                //   margin: 20.paddingH(context),
                //   hintText: lc(context).yourLastName,
                //   bottomSpace: 16,
                //   prefixIconPath: MyIcons.profileCircleIcon,
                //   controller: lNameController,
                //   textCapitalization: TextCapitalization.words,
                // ),
                MyTextFormField(
                  margin: 20.paddingH(context),
                  hintText: lc(context).emailAddress,
                  bottomSpace: 16,
                  prefixIconPath: MyIcons.emailMessage,
                  controller: emailController,
                ),
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
                MyElevatedButton(
                  text: lc(context).next,
                  onPressed: () {
                    authBloc.add(CreateAccountScreenEvent(
                      fName: fNameController!.text,
                      lName: "lNameController!.text",
                      email: emailController!.text,
                      password: passwordController!.text,
                      confirmPassword: confirmPasswordController!.text,
                    ));
                  },
                  padding: 20.paddingH(context),
                  textStyle: myTextStyle.font_20wMedium,
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
