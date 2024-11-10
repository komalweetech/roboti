import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_states.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/apple_login_repo.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_repo.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_request_parser.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_validator.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';
import 'package:the_apple_sign_in/scope.dart';

class LoginHandler {
  final AuthRepo _authRepo = AuthRepo();
  final AuthValidator _authValidator = AuthValidator();
  FutureOr<void> loginHandler(
    LoginEvents event,
    Emitter<AuthState> emit,
  ) async {
    if (event is GoogleLoginEvent) {
      await _googleLoginEvent(event, emit);
    } else if (event is AppleLoginEvent) {
      await _appleLoginEvent(event, emit);
    } else if (event is LoginButtonPressEvent) {
      await _manualLoginEvent(event, emit);
    }
  }

  Future<void> _manualLoginEvent(
    LoginButtonPressEvent event,
    Emitter<AuthState> emit,
  ) async {
    // The below check is used to validate the credentials,
    // If the email and the password are valid, only then the
    // Api calling function will get executed.
    if (_authValidator.loginCredentialsValid(event)) {
      // Loading state inorder to update the UI
      emit(LoginButtonPressLoadingState());

      // Api response tracker.
      LoginResponse response = LoginResponse.initial();
      // Calling the manual login API
      response = await _authRepo.manualLogin(
        email: event.email,
        password: event.password,
      );

      if (response.accessToken != null) {
        authBloc.user.email = response.email!;
        // This check is to detect that either there is an error returned or
        // not, because if there is any error then, we need to notify the user
        if (response.isVerified!) {
          homeBloc.add(RefreshAppLanguageEvent());
          await getIt<SharedPrefsManager>().saveUser(response);
          emit(LoginButtonPressSuccessState());
        } else {
          ErrorMessages.display(lcGlobal.accountVerificationRequired);
          await _authRepo.sendOtp(response.email!, allowLoading: false);
          emit(OtpNotVerifiedState());
        }
      } else {
        // Displaying the message
        ErrorMessages.display(response.message);
        // Updating the state of the UI
        emit(LoginButtonPressErrorState());
      }
    }
  }

  Future<void> _appleLoginEvent(
    LoginEvents event,
    Emitter<AuthState> emit,
  ) async {
    CustomCupertinoLoader.showLoaderDialog();
    emit(AppleLoginLoadingState());

    LoginResponse responseOBJ = LoginResponse.initial();

    try {
      final user = await AppleLoginService()
          .signInWithApple(scopes: [Scope.fullName, Scope.email]);

      String url = ApiUrls.appleLoginUrl;
      NetworkApiService apiService = NetworkApiService();
      final appleUser = user.last;
      String deviceToken = await _authRepo.getDeviceId();

      String request = AuthRequestParser().appleSignInRequestBody(
        deviceId: deviceToken,
        firstName: '', // user[1].displayName.split("")[0],
        lastName: '', // user[1].displayName.split("")[1],
        authCode: String.fromCharCodes(user[0].authorizationCode!),
        email: (appleUser.email ?? 'privaterelay.appleid')
                .toString()
                .contains('privaterelay.appleid')
            ? ''
            : appleUser.email,
      );

      Map<String, dynamic> response = await apiService.getPostApiResponse(
        url,
        request,
        addAccessToken: false,
      );
      LogManager.log(head: 'Apple ERROR', msg: response.toString());
      responseOBJ = LoginResponse.fromJson(response, fromSocialLogin: true);
    } catch (e) {
      CustomCupertinoLoader.dispose();
      ErrorMessages.display(e.toString());
      return emit(LoginButtonPressErrorState());
    }
    LogManager.log(head: '_appleLoginEvent', msg: '$responseOBJ');

    if (responseOBJ.accessToken == null) {
      CustomCupertinoLoader.dispose();
      ErrorMessages.display(responseOBJ.message, durationInMS: 3000);
      emit(LoginButtonPressErrorState());
    } else {
      CustomCupertinoLoader.dispose();
      homeBloc.add(RefreshAppLanguageEvent());
      await getIt<SharedPrefsManager>().saveUser(responseOBJ);
      MySnackbar.showSnackbar(responseOBJ.message);
      emit(LoginButtonPressSuccessState());
    }
  }

  Future<void> _googleLoginEvent(
    LoginEvents event,
    Emitter<AuthState> emit,
  ) async {
    // Trigger the google login code here

    emit(GoogleLoginLoadingState());

    LoginResponse response = await _authRepo.loginWithGoogle();

    if (response.accessToken == null) {
      ErrorMessages.display(response.message);
      emit(LoginButtonPressErrorState());
    } else {
      homeBloc.add(RefreshAppLanguageEvent());
      await getIt<SharedPrefsManager>().saveUser(response);
      MySnackbar.showSnackbar(response.message);
      emit(LoginButtonPressSuccessState());
    }
  }

  // Future<void> _signInWithApple(BuildContext context) async {
  //   AuthRequestParser reqParser = AuthRequestParser();
  //   // try {
  //   final user = await AppleLoginService()
  //       .signInWithApple(scopes: [Scope.fullName, Scope.email]);
  //   String url = ApiUrls.appleLoginUrl;
  //   // print(user[1].displayName.split("")[0]);
  //   // print(user[1].displayName.split("")[1]);
  //   // print(user[1].email);
  //   // print(String.fromCharCodes(user[0].authorizationCode!));
  //   String request = reqParser.appleSignInRequestBody(
  //     deviceId: "abcdefg",
  //     firstName: "", // user[1].displayName.split("")[0],
  //     lastName: "", // user[1].displayName.split("")[1],
  //     authCode: String.fromCharCodes(user[0].authorizationCode!),
  //     email: user[1].email,
  //   );

  //   NetworkApiService apiService = NetworkApiService();

  //   var response = await apiService.getPostApiResponse(url, request,
  //       addAccessToken: false);

  //   print(response);
  //   LoginResponse responseObj =
  //       LoginResponse.fromJson(response, fromSocialLogin: true);

  //   await getIt<SharedPrefsManager>().saveUser(responseObj);
  //   context.pushNamed(BaseScreen.route);
  //   // print(user.fullName!.namePrefix);
  //   // print(user.email);
  //   // print(user.fullName!.nameSuffix);
  //   // print(user.authorizationCode);
  //   // } catch (e) {
  //   //   print(e.toString());
  //   //   print(e);
  //   // }
  // }
}
