import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  // static const String _baseUrl = "https://api.roboti.app";
  // static const String _baseUrl = "http://robitibackendv2-env.eba-btujbc8b.us-east-1.elasticbeanstalk.com";
  // static const String _baseUrl = "http://robitibackendv2-env.eba-btujbc8b.us-east-1.elasticbeanstalk.com";
  // static const String _baseUrl = "http://new-robitibackend-env.eba-ymbmaa7z.us-east-1.elasticbeanstalk.com";
  // static const String _baseUrl =
  //     "http://robitibackend-env-withlb.eba-ymbmaa7z.us-east-1.elasticbeanstalk.com";
  // static const String _liveUrl = "https://3fklj7v9-8080.inc1.devtunnels.ms";
  static const String _liveUrl = "https://api.roboti.app";
  // static const String _tunnelUrl = "https://3fklj7v9-8080.inc1.devtunnels.ms";
  // static const String _stagingUrl = "https://dev-api.roboti.app";

  static const String _baseUrl = _liveUrl;
  // "https://robitibackend-env-withlb.eba-ymbmaa7z.us-east-1.elasticbeanstalk.com";

  static const String _userBaseUrl = "$_baseUrl/user";
  // static const String _userTunnelUrl = "$_tunnelUrl/user";
  // static const String _stagingUserBaseUrl = "$_baseUrl/user";

  // Auth Endpoints
  static const String googleLoginUrl = "$_userBaseUrl/googleLogin";
  static const String manualLoginUrl = "$_userBaseUrl/login";
  static const String signupUrl = "$_userBaseUrl/signUp";
  static const String singupOtpVerificationUrl =
      "$_userBaseUrl/signip_otp_verification";
  static const String sentOtpUrl = "$_userBaseUrl/send_otp";
  static const String forgotPasswordUrl = "$_userBaseUrl/forgot_password";
  static const String deleteAccountUrl = "$_userBaseUrl/deleteUser";
  static const String forgotPasswordOtpVerificationUrl =
      "$_userBaseUrl/forgot_password_otp";
  static const String resetPasswordUrl = "$_userBaseUrl/reset_password";
  static const String appleLoginUrl = "$_userBaseUrl/appleLogin";

  // Categories Endpoints
  static const String categoriesUrl = "$_userBaseUrl/getcategory";

  // Send FCM Endpoints
  static const String sendFCMUrl = "$_userBaseUrl/updateFCM";

  // Tasks Endpoints
  static const String tasksUrl = "$_userBaseUrl/getTask";

  // Fields Endpoints
  static const String fieldsUrl = "$_userBaseUrl/getField";

  static const String chatCompletionOpenAIUrl =
      "https://api.openai.com/v1/chat/completions";

  static const String googleTranslationUrl =
      "https://translation.googleapis.com/language/translate/v2";

  static const String uploadImage = "$_userBaseUrl/image";

  // Update Profile
  static const String updateProfile = "$_userBaseUrl/profile";
  static const String getProfile = "$_userBaseUrl/profile";
  static const String updateCounter = "$_userBaseUrl/updateTrialCounter";
  static const String resetCounter = "$_userBaseUrl/updateTrialCounterToEmpty";

  // Update Subscription Info
  static const String subscriptionUrl =
      "$_userBaseUrl/updateSubscriptionStatus";

  // News Api
  static const String globalNews = "$_userBaseUrl/globalNews";
  static const String robotiNews = "$_userBaseUrl/robotiNews";

  // History
  static const String createHistory = "$_userBaseUrl/storeHistory";
  static const String getAllHistory = "$_userBaseUrl/getHistory";
  static const String getHistoryByID = "$_userBaseUrl/getHistoryDetails";
  static const String updateHistory = "$_userBaseUrl/updateHistory";

  // Version
  static const String versionApi = "$_userBaseUrl/version";
}

class ForceUpdateUrls {
  static const String _appStoreUrl =
      "https://apps.apple.com/us/app/roboti/id6470292489";
  static const String _playStoreUrl = "";

  static String get getAppUrl {
    if (Platform.isIOS) {
      return _appStoreUrl;
    }
    return _playStoreUrl;
  }
}

class ApiKeys {
  static var googleApiKey = dotenv.env['googleApiKey'];
  static var openAiKey = dotenv.env['openAiKey'];
  static var revenueCatAppleKey = dotenv.env['revenueCatAppleKey'];
  static var robotiShareUrl = dotenv.env['revenueCatAppleKey'];
}
