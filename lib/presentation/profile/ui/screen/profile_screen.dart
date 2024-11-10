import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/appbar/roboti_logo_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/my_text_field.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view/widgets/select_country_field.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/ui/widget/upload_profile_image.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_events.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_states.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "profile_screen.dart";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showPassword = false, showConfirmPassword = false;
  TextEditingController? countryController, nameController, emailController;
  LoginResponse? user;

  @override
  void initState() {
    super.initState();
    _initiateControllers();
  }

  void _initiateControllers() {
    user = homeBloc.loginResponse;
    nameController = TextEditingController();
    nameController!.text = user!.name ?? "";
    emailController = TextEditingController();
    emailController!.text = user!.email ?? "";
    countryController = TextEditingController();
    countryController!.text = user!.country ?? "";
    profileBloc.image = null;
  }

  @override
  void dispose() {
    countryController!.dispose();
    nameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const RobotiLogoAppbar(),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) {
            if (state is UpdateProfileSuccessNavigateState) {
              // context.pop();
            }
          },
          builder: (context, state) => ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              TextView(
                lc(context).editProfileDetails,
                style: myTextStyle.font_25wRegular,
                padding: 20.paddingH(context),
              ),
              34.vSpace(context),
              const UploadProfileImageWidget(),
              20.vSpace(context),
              MyTextFormField(
                margin: 20.paddingH(context),
                hintText: lc(context).yourFullName,
                bottomSpace: 16,
                prefixIconPath: MyIcons.profileCircleIcon,
                controller: nameController,
                textCapitalization: TextCapitalization.words,
              ),
              if (emailController!.text.isEmpty)
                Padding(
                  padding: 20.paddingH(context).copyWith(bottom: 20),
                  child: Text(
                    '${lc(context).youLoggedInAs} ${lc(context).anonymousUser}',
                    style: 16.txt(context).textColor(MyColors.white585f78),
                  ),
                )
              else
                MyTextFormField(
                  margin: 20.paddingH(context),
                  hintText: lc(context).emailAddress,
                  bottomSpace: 16,
                  readOnly: true,
                  onTap: () =>
                      ErrorMessages.display(lcGlobal.emailCannotBeChanged),
                  prefixIconPath: MyIcons.emailMessage,
                  controller: emailController,
                ),
              ChooseCountryWidget(
                controller: countryController!,
                onSelected: (country) =>
                    setState(() => countryController!.text = country.name),
              ),
              20.vSpace(context),
              MyLoaderElvButton(
                state: state,
                text: lc(context).save,
                onPressed: () => profileBloc.add(UpdateProfileEvent(
                  name: nameController!.text,
                  country: countryController!.text,
                  file: profileBloc.image,
                )),
                padding: 16.paddingH(context),
                textStyle: myTextStyle.font_20wMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
