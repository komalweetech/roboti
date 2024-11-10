// import 'dart:js_interop';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/auth/model/auth_user.dart';
import 'package:roboti_app/presentation/auth/model/google_login_response.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/apple_login_repo.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_request_parser.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/google_login_repo.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';

class AuthRepo {
  GoogleLoginSerice gLogin = GoogleLoginSerice();
  AppleLoginService aLogin = AppleLoginService();
  NetworkApiService services = NetworkApiService();
  AuthRequestParser requestParser = AuthRequestParser();

  Future<LoginResponse> loginWithGoogle() async {
    LoginResponse response = LoginResponse.initial();
    CustomCupertinoLoader.showLoaderDialog();

    // Calling the Google Login Api and fetching the response containing
    // the idToken and accessToken. Null returned will be considered as "Something
    // went wrong" so display a message
    GoogleLoginResponse? googleLoginResponse = await gLogin.signInWithGoogle();

    if (googleLoginResponse == null) {
      CustomCupertinoLoader.dispose();
      return LoginResponse.fromJson(
        {"data": null, "message": lcGlobal.signInFailedPleaseTryAgainLater},
      );
    }

    // Step 1 # Get Device Token
    String deviceId = await getDeviceId();

    // Step 2 # Call the Google SL Api
    Map<String, dynamic> responseMap =
        await callGoogleLoginApi(deviceId, googleLoginResponse);
    CustomCupertinoLoader.dispose();

    response = LoginResponse.fromJson(responseMap, fromSocialLogin: true);

    return response;
  }

  Future<String> getDeviceId() async {
    String deviceId = "";

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;

    Map<String, dynamic> data = deviceInfo.data;

    deviceId = data['id'] ?? data['identifierForVendor'];
    return deviceId;
  }

  Future<LoginResponse> manualLogin({
    required String email,
    required String password,
  }) async {
    String requestBody = requestParser.manualLoginRequestBody(email, password);
    LoginResponse responseBody = LoginResponse.initial();
    // try {
    Map<String, dynamic> response = await services.getPostApiResponse(
      ApiUrls.manualLoginUrl,
      requestBody,
      addAccessToken: false,
      contentTypeJson: true,
    );

    responseBody = LoginResponse.fromJson(response);
    // } catch (e) {}

    return responseBody;
  }

  Future<Map<String, dynamic>> callGoogleLoginApi(
    String deviceId,
    GoogleLoginResponse googleLoginResponse,
  ) async {
    Map<String, dynamic> responseBody;

    String requestBody =
        requestParser.googleSignInRequestBody(googleLoginResponse, deviceId);

    // try {
    responseBody = await services.getPostApiResponse(
      ApiUrls.googleLoginUrl,
      requestBody,
      addAccessToken: false,
    );
    // } catch (e) {
    //   print(e.toString());
    //   responseBody = {"data": null, "message": e.toString()};
    // }

    return responseBody;
  }

  Future<Map<String, dynamic>> signUp(UserModel user) async {
    String deviceToken = await getDeviceId();
    String requestBody = requestParser.signUpRequestBody(user, deviceToken);
    Map<String, dynamic> response = {};
    response = await services.getPostApiResponse(
      ApiUrls.signupUrl,
      requestBody,
      addAccessToken: false,
    );

    return response;
  }

  Future<void> sendOtp(String email, {bool allowLoading = true}) async {
    if (allowLoading) CustomCupertinoLoader.showLoaderDialog();

    String requestBody = requestParser.sendOtpRequestBody(email);
    Map<String, dynamic> response = {};
    response = await services.getPostApiResponse(
      ApiUrls.sentOtpUrl,
      requestBody,
      addAccessToken: false,
    );

    MySnackbar.showSnackbar(response['message']);

    if (allowLoading) CustomCupertinoLoader.dispose();
  }

  Future<LoginResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    String requestBody = requestParser.verifyOtpRequestBody(email, otp);
    LoginResponse response = LoginResponse.initial();
    Map<String, dynamic> responseMap = await services.getPostApiResponse(
      ApiUrls.singupOtpVerificationUrl,
      requestBody,
      addAccessToken: false,
    );

    response = LoginResponse.fromJson(responseMap);

    return response;
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    String requestBody = requestParser.forgotPasswordRequestBody(email);
    Map<String, dynamic> responseMap = await services.getPostApiResponse(
      ApiUrls.forgotPasswordUrl,
      requestBody,
      addAccessToken: false,
    );
    return responseMap;
  }

  Future<Map<String, dynamic>> deleteAccount({
    required String userID,
  }) async {
    Map<String, dynamic> responseMap = {};

    try {
      responseMap = await services.getPostApiResponse(
        "${ApiUrls.deleteAccountUrl}/$userID",
        "",
        addAccessToken: true,
      );
    } catch (e) {
      responseMap = {"data": null, "message": e.toString()};
    }
    return responseMap;
  }

  Future<LoginResponse> verifyForgotPasswordOtp(
      String otp, String email) async {
    String requestBody = requestParser.verifyOtpRequestBody(email, otp);

    LoginResponse response = LoginResponse.initial();
    Map<String, dynamic> responseMap = await services.getPostApiResponse(
      ApiUrls.forgotPasswordOtpVerificationUrl,
      requestBody,
      addAccessToken: false,
    );

    response = LoginResponse.fromJson(responseMap);

    return response;
  }

  Future<Map<String, dynamic>> resetPassword(
      String email, String password) async {
    String requestBody = requestParser.manualLoginRequestBody(email, password);

    Map<String, dynamic> responseMap = await services.getPostApiResponse(
      ApiUrls.resetPasswordUrl,
      requestBody,
      addAccessToken: false,
    );

    return responseMap;
  }
}
