import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_states.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_repo.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_validator.dart';

class ForgotPassHandler {
  final AuthValidator _authValidator = AuthValidator();
  final AuthRepo _authRepo = AuthRepo();
  FutureOr<void> forgotPassHandler(
    ForgotPassEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event is ForgotPasswordEmailAddedEvent) {
      await forgotPasswordEmailAddedEvent(event, emit);
    } else if (event is ForgotPasswordOtpEvent) {
      await forgotPasswordOtpEvent(event, emit);
    } else if (event is ResetPasswordApiEvent) {
      await resetPasswordApiEvent(event, emit);
    }
  }

  Future<void> forgotPasswordEmailAddedEvent(
    ForgotPasswordEmailAddedEvent event,
    Emitter<AuthState> emit,
  ) async {
    primaryFocus!.unfocus();
    if (_authValidator.forgotPasswordEmailValid(event)) {
      emit(ForgotPasswordOtpLoadingState());

      Map<String, dynamic> response =
          await _authRepo.forgotPassword(event.email);

      if (response.containsKey("data") &&
          response['data'] != null) {
        authBloc.user.email = event.email;
        MySnackbar.showSnackbar(response['message']);
        emit(ForgotPasswordOtpSuccessState());
      } else {
        ErrorMessages.display(response['message']);
        emit(ForgotPasswordOtpErrorState());
      }
    }
  }

  Future<void> forgotPasswordOtpEvent(
    ForgotPasswordOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    primaryFocus!.unfocus();
    if (event.otp.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterTheCorrectOtp);
    } else if (event.otp.length != 5) {
      ErrorMessages.display(lcGlobal.otpMustBe5DigitsLong);
    } else {
      emit(ForgotPasswordOtpVerificationLoadingState());

      LoginResponse response = await _authRepo.verifyForgotPasswordOtp(
        event.otp,
        authBloc.user.email,
      );

      if (response.accessToken == null) {
        ErrorMessages.display(response.message);
        emit(ForgotPasswordOtpVerificationErrorState());
      } else {
        MySnackbar.showSnackbar(response.message);
        emit(ForgotPasswordOtpVerificationSuccessState());
      }
    }
  }

  Future<void> resetPasswordApiEvent(
    ResetPasswordApiEvent event,
    Emitter<AuthState> emit,
  ) async {
    primaryFocus!.unfocus();
    if (_authValidator.resetPasswordFieldsValid(event)) {
      emit(ResetPasswordApiLoadingState());

      Map<String, dynamic> response = await _authRepo.resetPassword(
        authBloc.user.email,
        event.password,
      );

      if (response.containsKey("data") &&
          response['data'] != null &&
          response["data"].isNotEmpty) {
        MySnackbar.showSnackbar(response['message']);
        emit(ResetPasswordApiSuccessState());
      } else {
        ErrorMessages.display(response['message']);
        emit(ResetPasswordApiErrorState());
      }
    }
  }
}
