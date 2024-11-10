import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/auth/view/widgets/password_input_field.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_states.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class PasswordConfirmation extends StatefulWidget {
  static const String route = "password_confirmation";
  const PasswordConfirmation({super.key});

  @override
  State<PasswordConfirmation> createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  @override
  void initState() {
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController!.dispose();
    super.dispose();
  }

  LoginResponse user = homeBloc.loginResponse;
  bool _obscure = false;
  TextEditingController? _passwordController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MyAppBar(
          title: MyLogoWidget(),
          leadingWidget: MyBackButton(),
        ),
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is DeleteAccountSuccessState) {
                context.pushNamedAndRemoveUntil(SignInScreen.route);
              }
            },
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //const AuthAppbar(),
                TextView(
                  lc(context).enterPassword,
                  style: myTextStyle.font_39wMedium,
                  padding: 20.paddingH(context),
                ),
                MyRichText(
                  text1: lc(context).pleaseEnterYourPasswordToProceed,
                  text2: user.email!,
                  style1: myTextStyle.font_20wMedium.regular.copyWith(
                    color: MyColors.whiteFFFFFF,
                  ),
                  style2: myTextStyle.font_20wMedium.regular.copyWith(
                    color: MyColors.blue2575FC,
                  ),
                  margin: 20.paddingH(context),
                ),
                const Spacer(),
                PasswordInputField(
                  controller: _passwordController,
                  hintText: lc(context).password,
                  obscure: _obscure,
                  onObscureTap: (value) => setState(() => _obscure = !_obscure),
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                4.vSpace(context),
                MyLoaderElvButton(
                  state: state,
                  text: lc(context).deleteYourAccount,
                  onPressed: () {
                    authBloc.add(DeleteAccountWithPasswordEvent());
                  },
                  padding: 16.paddingH(context),
                  textStyle: myTextStyle.font_20wMedium,
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
