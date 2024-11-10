import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_states.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_repo.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_validator.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

class SignUpHandler {
  final AuthRepo _authRepo = AuthRepo();
  final AuthValidator _authValidator = AuthValidator();
  FutureOr<void> signupHandler(
    SignupEvents event,
    Emitter<AuthState> emit,
  ) async {
    if (event is CreateAccountScreenEvent) {
      await createAccountScreenEvent(event, emit);
    } else if (event is SignupOtpEvent) {
      await signupOtpEvent(event, emit);
    } else if (event is ResendOtpEvent) {
      await _authRepo.sendOtp(event.email);
    } else if (event is CountrySelectedEvent) {
      countrySelectedEvent(event, emit);
    } else if (event is CreateAccountApiEvent) {
      await createAccountApiEvent(event, emit);
    }
  }

  Future<void> createAccountApiEvent(
    CreateAccountApiEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(CreateAccountApiLoaderState());

    Map<String, dynamic> response = await _authRepo.signUp(authBloc.user);

    if (response.containsKey("data") &&
        (response['data'] != null && response['data'].isNotEmpty)) {
      emit(CreateAccountApiSuccessState());
      MySnackbar.showSnackbar(response['message']);
    } else {
      emit(CreateAccountApiErrorState());
      ErrorMessages.display(response['message']);
    }
  }

  countrySelectedEvent(CountrySelectedEvent event, Emitter<AuthState> emit) {
    authBloc.user.countryCode = event.country.countryCode;
    authBloc.user.countryName = event.country.name;

    emit(CountrySelectedState());
  }

  Future<void> createAccountScreenEvent(
    CreateAccountScreenEvent event,
    Emitter<AuthState> emit,
  ) async {
    // The below check is used to validate the credentials,
    // If the email and the password are valid, only then the
    // Api calling function will get executed.
    bool success = _authValidator.signUpCredentialsValid(event);
    if (success) {
      authBloc.user.update(
        fName: event.fName,
        lName: event.lName,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      emit(CreateNewAccountState());
    }
  }

  Future<void> signupOtpEvent(
    SignupOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event.otp.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterYourOtp);
    } else if (event.otp.length != 5) {
      ErrorMessages.display(lcGlobal.otpOf5DigitsIsRequired);
    } else {
      emit(VerifyOtpLoadingState());
      LoginResponse response =
          await _authRepo.verifyOtp(email: authBloc.user.email, otp: event.otp);
      if (response.accessToken != null) {
        await getIt<SharedPrefsManager>().saveUser(response);
        MySnackbar.showSnackbar(response.message);
        emit(VerifyOtpSuccessState());
      } else {
        ErrorMessages.display(response.message);
        emit(VerifyOtpErrorState());
      }
    }
    // print(event);
  }
}
