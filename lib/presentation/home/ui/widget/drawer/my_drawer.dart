// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/auth/view/widgets/delete_account_popup.dart';
import 'package:roboti_app/presentation/contact-us/ui/screens/contact-us.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/drawer_close_btn.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/drawer_tile.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/drawer_user_profile_tile.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/logout_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/version_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_plan.dart';
import 'package:roboti_app/presentation/terms_and_condition/ui/screen/terms_and_condition.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

class MyDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> navigationKey;
  const MyDrawer({super.key, required this.navigationKey});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerColor: MyColors.pinFieldBlue141F48,
        dividerTheme: DividerThemeData(color: MyColors.pinFieldBlue141F48),
      ),
      child: Drawer(
        width: 92.8.percentWidth(context),
        backgroundColor: MyColors.primaryDarkBlue060A19,
        child: SafeArea(
          child: Column(
            children: [
              // DrawerHeader(
              //   padding: EdgeInsets.zero,
              //   margin: EdgeInsets.zero,

              //   child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.pxH(context),
                      right: 17.pxH(context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyLogoWidget(),
                        DrawerCloseButton(
                          onTap: () =>
                              navigationKey.currentState!.closeDrawer(),
                        ),
                      ],
                    ),
                  ),
                  18.vSpace(context),
                  DrawerUserProfileTile(profile: homeBloc.loginResponse),
                ],
              ),
              25.8.vSpace(context),
              // ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if (Platform.isIOS)
                      DrawerTile(
                        onTap: () {
                          context.pushNamed(SubscriptionPlan.route);
                        },
                        title: lc(context).manageSubscription,
                        subTitle: lc(context).manageSubscriptionSubtitle,
                        icon: MyIcons.homeTapped,
                      ),
                    DrawerTile(
                      onTap: () {
                        context.pushNamed(TermsAndConditionScreen.route);
                      },
                      title: lc(context).termsOfUseCaptalize,
                      subTitle: lc(context).reviewTheRulesForUsingRoboti,
                      icon: MyIcons.homeTapped,
                    ),
                    DrawerTile(
                      onTap: () {
                        context.pushNamed(PrivacyPolicyScreen.route);
                      },
                      title: lc(context).privacyPolicy,
                      subTitle: lc(context).understandOurDataPrivacyCommitments,
                      icon: MyIcons.homeTapped,
                    ),
                    DrawerTile(
                      onTap: () {
                        context.pushNamed(ContactUsScreen.route);
                      },
                      title: lc(context).contactUs,
                      subTitle: lc(context).contactTheSupport,
                      icon: MyIcons.homeTapped,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 1,
                    width: 100.percentWidth(context),
                    margin: 17.paddingRight(context),
                    color: MyColors.pinFieldBlue141F48,
                  ),
                  17.5.vSpace(context),
                  VersionWidget(
                    padding: EdgeInsets.only(
                      left: 31.pxH(context),
                      right: 22.pxH(context),
                    ),
                  ),
                  14.vSpace(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      21.hSpace(context),
                      LogoutButton(
                        onTap: () async => await _logout(context),
                        padding: 14.paddingH(context),
                        leading: SvgPicture.asset(
                          MyIcons.logout,
                          width: 16.0.pxH(context),
                          height: 16.0.pxV(context),
                          color: Colors.red,
                        ),
                        color: Colors.red,
                        text: lc(context).logout,
                      ),
                      const Spacer(),
                      LogoutButton(
                        onTap: () => _deleteAccount(context),
                        padding: 14.paddingH(context),
                        color: const Color(0xff585f78),
                        leading: Container(
                          width: 18.pxH(context),
                          height: 18.pxV(context),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff585f78),
                            ),
                          ),
                          child: const Icon(
                            Icons.clear,
                            size: 12,
                            color: Color(0xff585f78),
                          ),
                        ),
                        text: lc(context).deleteYourAccountUnCaptalize,
                      ),
                      12.hSpace(context),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await getIt<SharedPrefsManager>().removeUserToken();
    subscriptionBloc.resetTimer();
    // await PurchaseService().disposeListener();
    context.pushNamedAndRemoveUntil(SignInScreen.route);
  }

  Future<void> _deleteAccount(BuildContext context) async {
    subscriptionBloc.resetTimer();
    context.pop();
    DeleteAccount.deleteAccountPopup();
  }
}
