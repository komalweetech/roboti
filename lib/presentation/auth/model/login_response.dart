import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/service/remote/api_headers.dart';
import 'package:roboti_app/utils/extensions/date_time.dart';
import 'package:roboti_app/utils/extensions/string_extendsions.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';

class LoginResponse {
  String? email;
  bool? isActive;
  bool? isVerified;
  String? accessToken;
  String? name, fName, lName;
  String message;
  String? id;
  String imageUrl;
  int trialCounter;
  String? country;
  File? file;
  DateTime? planExpireAt;
  PlanType planType;
  bool isPlanActive;

  LoginResponse({
    required this.email,
    required this.isActive,
    required this.isVerified,
    required this.accessToken,
    required this.message,
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.fName,
    required this.lName,
    required this.country,
    required this.planExpireAt,
    required this.planType,
    required this.isPlanActive,
    required this.trialCounter,
  });

  LoginResponse.initial()
      : email = null,
        isActive = null,
        isVerified = null,
        accessToken = null,
        name = null,
        id = null,
        message = "",
        imageUrl = "",
        country = "",
        planType = PlanType.none,
        isPlanActive = false,
        file = null,
        trialCounter = 0;

  factory LoginResponse.fromJson(
    Map<String, dynamic> json, {
    bool fromSocialLogin = false,
  }) {
    final LoginResponseParser parser = LoginResponseParser();
    // if (fromSocialLogin) {
    //   return parser.fromSocialLogin(json);
    // }
    return parser.fromSystemLogin(json, fromSocialLogin);
  }

  void updatePkgInfo(Map<String, dynamic> json) {
    isPlanActive = json['data'] == null ||
            json['data']['response'] == null ||
            json['data']['response']['isPlanActive'] == null
        ? false
        : json['data']['response']['isPlanActive'];

    planType = json['data'] == null ||
            json['data']['response'] == null ||
            json['data']['response']['planType'] == null
        ? PlanType.none
        : getPlanType(json['data']['response']['planType'].toString());
    planExpireAt = json['data'] == null ||
            json['data']['response'] == null ||
            json['data']['response']['planExpireAt'] == null
        ? null
        : DateTime.parse(json['data']['response']['planExpireAt']);
  }

  void updatePkgInfoFromRevenueCat({required CustomerInfo info}) {
    String date = info.latestExpirationDate ?? "";
    subscriptionBloc.recentSubscriptionExpiryDate = date;
    if (date.isEmpty) {
      date =
          DateTime.now().toUtc().subtract(const Duration(days: 1)).toString();
    }
    isPlanActive = _getPlanStatus(info.latestExpirationDate);
    String type = "5";
    if (info.activeSubscriptions.isNotEmpty) {
      String type = info.activeSubscriptions.first.toString().toLowerCase();
      if (type.contains("week")) {
        type = "1";
      } else if (type.contains("month")) {
        type = "2";
      } else if (type.contains("year")) {
        type = "3";
      }
    }

    planType = getPlanType(type);
    planExpireAt = DateTime.parse(date);
  }

  bool _getPlanStatus(String? date) {
    if (date == null) return false;

    DateTime expiry = DateTime.parse(date);
    DateTime now = DateTime.now().toUtc();
    LogManager.log(
      head: 'Subcription Check',
      msg: 'expiry = $expiry, now = $now',
    );

    return expiry.isAtSameMomentOrIsAfter(now);
  }

  set setEmail(String? email) => email;
  set setName(String? name) => name;
  set setToken(String? name) => accessToken;
  set setId(String? id) => id;
  set setImage(String image) => imageUrl;

  static String get fNameKey => "f_name";
  static String get lNameKey => "l_name";
  static String get nameKey => "name";
  static String get tokenKey => "token";
  static String get emailKey => "email";
  static String get trialCounterKey => "trial_counter";
  static String get idKey => "user_id";
  static String get countryKey => "country";
  static String get imageKey => "image_url";
  static String get trialMember => "trial_member";
  static String get planExpiryDate => "plan_expiry";
  static String get isPlanActiveKey => "is_plan_active";
  static String get planTypeKey => "plan_type";

  void update({
    String? email,
    String? userName,
    String? token,
    String? image,
    File? imgFile,
  }) {
    imageUrl = image ?? imageUrl;
    name = userName ?? name;
    accessToken = token ?? accessToken;
    file = imgFile;
  }

  void copy(LoginResponse response, {bool updateExpiry = true}) {
    // print(response.toString());
    accessToken = response.accessToken;
    email = response.email;
    isActive = response.isActive;
    isVerified = response.isVerified;
    name = response.name;
    fName = response.fName;
    lName = response.lName;
    message = response.message;
    id = response.id;
    imageUrl = response.imageUrl;
    country = response.country;
    if (updateExpiry) planExpireAt = response.planExpireAt;
    planType = response.planType;
    isPlanActive = response.isPlanActive;
  }

  String getPlanTypeString() {
    switch (planType) {
      case PlanType.weekly:
        return "1";
      case PlanType.monthly:
        return "2";
      case PlanType.yearly:
        return "3";
      default:
        return "none";
    }
  }

  factory LoginResponse.fromUpdateProfile(Map<String, dynamic> json) {
    String? name = LoginResponseParser._getName(json, fromEmail: false);

    Map<String, dynamic> response = json['data']['response'];

    return LoginResponse(
      email: response['email'],
      isActive: response['isActive'],
      isVerified: response['isVerified'],
      accessToken: ApiHeaders.userAccessToken,
      message: json['message'],
      name: name,
      id: response['_id'],
      imageUrl: response['profilePicture'],
      fName: response['firstName'],
      lName: response['lastName'],
      country: response['countryCode'],
      planExpireAt: response['planExpireAt'] == null
          ? null
          : DateTime.parse(response['planExpireAt'].toString()),
      planType: getPlanType(response['planType'].toString()),
      isPlanActive: response['isPlanActive'] ?? false,
      trialCounter: response['trial_counter'] ?? 0,
    );
  }
}

enum PlanType { none, weekly, monthly, yearly }

PlanType getPlanType(String type) {
  switch (type) {
    case "1":
      return PlanType.weekly;

    case "2":
      return PlanType.monthly;

    case "3":
      return PlanType.yearly;

    default:
      return PlanType.none;
  }
}

class LoginResponseParser {
  LoginResponse fromSocialLogin(Map<String, dynamic> json) {
    String? name = _getName(json);
    return LoginResponse(
      email: json['data']['email'],
      isActive: null,
      isVerified: null,
      accessToken: json['data']['token'],
      message: json['message'],
      name: name,
      id: json['data']['_id'],
      imageUrl: "",
      fName: null,
      lName: null,
      country: "",
      isPlanActive: json['data']['isPlanActive'] ?? false,
      planType: json['data']['planType'] == null
          ? PlanType.none
          : getPlanType(json['data']['planType'].toString()),
      planExpireAt: json['data']['planExpireAt'] == null
          ? null
          : json['data']['planExpireAt'] == null
              ? null
              : DateTime.parse(json['data']['planExpireAt']),
      trialCounter: json['data']['trial_counter'] ?? 0,
    );
  }

  Map<String, dynamic>? _returnUserBody(
      Map<String, dynamic> json, bool fromSocialLogin) {
    if (fromSocialLogin) {
      return json['data']?['user'];
    }
    return json['data']?['response'];
  }

  LoginResponse fromSystemLogin(
    Map<String, dynamic> json,
    bool fromSocialLogin,
  ) {
    Map<String, dynamic>? user = _returnUserBody(json, fromSocialLogin);
    return LoginResponse(
      email: user?['email'],
      isActive: user?['isActive'],
      isVerified: user?['isVerified'],
      accessToken: json['data']?['token'],
      message: json['message'],
      name: _getName(user),
      fName: user?['firstName'],
      lName: user?['lastName'],
      id: user?['_id'],
      imageUrl: user == null ? "" : user['profilePicture'],
      country: user?['countryCode'],
      planExpireAt: user == null
          ? null
          : user['planExpireAt'] == null
              ? null
              : DateTime.parse(user['planExpireAt']),
      planType: user == null
          ? PlanType.none
          : getPlanType(user['planType'].toString()),
      isPlanActive: user == null ? false : user['isPlanActive'] ?? false,
      trialCounter: user?['trial_counter'] ?? 0,
    );
  }

  static String? _getName(Map<String, dynamic>? json,
      {bool fromEmail = false}) {
    if (fromEmail) {
      String name =
          json!['data']['email'].toString().split("@").first.capitalizeFirst();
      return name;
    }

    if (json == null || json.isEmpty) {
      return null;
    }
    String name = json['email'].toString().split("@").first.capitalizeFirst();

    if (json['firstName'] != null) {
      name = json['firstName'].toString().capitalizeFirst();

      if (json['lastName'] != null) {
        name = "$name ${json['lastName'].toString().capitalizeFirst()}";
      }
    }

    return name;
  }
}
