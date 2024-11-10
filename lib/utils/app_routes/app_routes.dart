import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/auth/view/screens/create_new_password.dart';
import 'package:roboti_app/presentation/auth/view/screens/forgot_password_screen.dart';
import 'package:roboti_app/presentation/auth/view/screens/otp_screen.dart';
import 'package:roboti_app/presentation/auth/view/screens/password_confirmation.dart';
import 'package:roboti_app/presentation/auth/view/screens/select_country_screen.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_up.dart';
import 'package:roboti_app/presentation/base_screen/ui/screen/base_screen.dart';
import 'package:roboti_app/presentation/chat/ui/screen/chat_screen.dart';
import 'package:roboti_app/presentation/contact-us/ui/screens/contact-us.dart';
import 'package:roboti_app/presentation/getting_started/ui/screen/get_started.dart';
import 'package:roboti_app/presentation/home/ui/screen/chat_response_screen.dart';
import 'package:roboti_app/presentation/home/ui/screen/fields_screen.dart';
import 'package:roboti_app/presentation/home/ui/screen/task_screen.dart';
import 'package:roboti_app/presentation/home/ui/screen/home_categpry_screen.dart';
import 'package:roboti_app/presentation/news/ui/screens/news_base_screen.dart';
import 'package:roboti_app/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:roboti_app/presentation/profile/ui/screen/profile_screen.dart';
import 'package:roboti_app/presentation/splash/ui/screen/splash_screen.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_success.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_plan.dart';
import 'package:roboti_app/presentation/terms_and_condition/ui/screen/terms_and_condition.dart';

class AppRoutes {
  final Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.route: (_) => const SplashScreen(),
    GetStartedScreen.route: (_) => const GetStartedScreen(),
    SignInScreen.route: (_) => const SignInScreen(),
    SignUpScreen.route: (_) => const SignUpScreen(),
    HomeCategoryScreen.route: (_) => const HomeCategoryScreen(),
    TasksScreen.route: (_) => const TasksScreen(),
    BaseScreen.route: (_) => const BaseScreen(),
    OtpScreen.route: (_) => const OtpScreen(),
    CreateNewPasswordScreen.route: (_) => const CreateNewPasswordScreen(),
    SelectCountryScreen.route: (_) => const SelectCountryScreen(),
    ForgotPasswordScreen.route: (_) => const ForgotPasswordScreen(),
    ChatScreen.route: (_) => const ChatScreen(),
    FieldsScreen.route: (_) => const FieldsScreen(),
    ChatResponseScreen.route: (_) => const ChatResponseScreen(),
    PrivacyPolicyScreen.route: (_) => const PrivacyPolicyScreen(),
    TermsAndConditionScreen.route: (_) => const TermsAndConditionScreen(),
    PasswordConfirmation.route: (_) => const PasswordConfirmation(),
    ProfileScreen.route: (_) => const ProfileScreen(),
    NewsBaseScreen.route: (_) => const NewsBaseScreen(),
    SubscriptionPlan.route: (_) => const SubscriptionPlan(),
    SubscriptionSuccessFull.route: (_) => const SubscriptionSuccessFull(),
    ContactUsScreen.route: (_) => const ContactUsScreen(),
  };

  // Animated Push
  Widget returnScreen(String route) {
    switch (route) {
      // For Get Start Screen
      case GetStartedScreen.route:
        return const GetStartedScreen();

      // For Sign in screen
      case SignInScreen.route:
        return const SignInScreen();

      // For Sign Up screen
      case SignUpScreen.route:
        return const SignUpScreen();

      // For Home screen
      case HomeCategoryScreen.route:
        return const HomeCategoryScreen();

      // For Category screen
      case TasksScreen.route:
        return const TasksScreen();

      // For Base screen
      case BaseScreen.route:
        return const BaseScreen();

      // For Create Password screen
      case CreateNewPasswordScreen.route:
        return const CreateNewPasswordScreen();

      // For Fotgot Password screen
      case ForgotPasswordScreen.route:
        return const ForgotPasswordScreen();

      // For Select Country screen
      case SelectCountryScreen.route:
        return const SelectCountryScreen();

      // For Otp screen
      case OtpScreen.route:
        return const OtpScreen();

      // For Chat screen
      case ChatScreen.route:
        return const ChatScreen();

      // Fields screen
      case FieldsScreen.route:
        return const FieldsScreen();

      // Chat response screen
      case ChatResponseScreen.route:
        return const ChatResponseScreen();

      // News screen
      case NewsBaseScreen.route:
        return const NewsBaseScreen();

      case PrivacyPolicyScreen.route:
        return const PrivacyPolicyScreen();

      case TermsAndConditionScreen.route:
        return const TermsAndConditionScreen();

      case PasswordConfirmation.route:
        return const PasswordConfirmation();

      case ContactUsScreen.route:
        return const ContactUsScreen();

      default:
        return Scaffold(
          body: Center(child: Text("${lcGlobal.noRouteWithName} $route")),
        );
    }
  }
}
