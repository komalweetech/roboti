// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/base_screen/ui/screen/base_screen.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/api_headers.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool oneTimeLogin = getUserToken();
    subscriptionBloc.add(InitializeSubscriptionEvent());
    // PurchaseService().setUserIdAsMetadata();

    Future.delayed(const Duration(milliseconds: 2500), () {
      context.pushReplacementNamed(
        oneTimeLogin ? BaseScreen.route : SignInScreen.route,
      );
    });
    super.initState();
  }

  bool getUserToken() {
    SharedPrefsManager prefsManager = getIt<SharedPrefsManager>();
    LoginResponse user = prefsManager.getUser();

    if (user.accessToken != null) {
      ApiHeaders.userAccessToken = user.accessToken!;
      homeBloc.loginResponse.copy(user);
      return user.accessToken!.isNotEmpty;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryDarkBlue060A19,
      body: Center(
        child: Lottie.asset(
          AnimationAssets.splash,
          height: 100.percentHeight(context),
          width: 100.percentWidth(context),
          fit: BoxFit.cover,
          repeat: false,
        ),
      ),
    );
  }
}
