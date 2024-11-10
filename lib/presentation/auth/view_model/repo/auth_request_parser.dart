import 'dart:convert';

import 'package:roboti_app/presentation/auth/model/auth_user.dart';
import 'package:roboti_app/presentation/auth/model/google_login_response.dart';

class AuthRequestParser {
  String googleSignInRequestBody(
      GoogleLoginResponse google, String deviceToken) {
    Map<String, dynamic> requestBody = {
      // "accessToken": google.accessToken,
      // "idToken": google.idToken,
      "deviceToken": deviceToken,
      "fullName": google.fullName,
      "email": google.email,
    };

    return jsonEncode(requestBody);
  }

  String appleSignInRequestBody({
    required String deviceId,
    required String email,
    required String firstName,
    required String lastName,
    required String authCode,
  }) {
    Map<String, dynamic> requestBody = {
      "deviceToken": deviceId,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "appleAuthCode": authCode,
    };

    return jsonEncode(requestBody);
  }

  String manualLoginRequestBody(String email, String password) {
    Map<String, dynamic> requestBody = {
      "emailOrphonenumber": email,
      "password": password,
    };

    return jsonEncode(requestBody);
  }

  String sendOtpRequestBody(String email) {
    return jsonEncode({"emailOrphonenumber": email});
  }

  String verifyOtpRequestBody(String email, String otp) {
    return jsonEncode({"emailOrphonenumber": email, "otp": otp});
  }

  String forgotPasswordRequestBody(String email) {
    return jsonEncode({"emailOrphonenumber": email});
  }

  String signUpRequestBody(UserModel user, String deviceToken) {
    Map<String, dynamic> requestBody = {
      "email": user.email,
      "password": user.password,
      "countryCode": user.countryName,
      "deviceToken": deviceToken,
      "firstName": user.fName,
      // "lastName": user.lName
    };
    return jsonEncode(requestBody);
  }
}
