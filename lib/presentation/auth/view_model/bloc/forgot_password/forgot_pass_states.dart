import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';

abstract class ForgotPassState extends AuthState {}

// Sending OTP
class ForgotPasswordOtpLoadingState extends ForgotPassState with LoaderState {}

class ForgotPasswordOtpErrorState extends ForgotPassState {}

class ForgotPasswordOtpSuccessState extends ForgotPassState {}

// Otp Verification for Forgot Password
class ForgotPasswordOtpVerificationLoadingState extends ForgotPassState
    with LoaderState {}

class ForgotPasswordOtpVerificationErrorState extends ForgotPassState {}

class ForgotPasswordOtpVerificationSuccessState extends ForgotPassState {}

// Create password for Forgot Password States

class ResetPasswordApiLoadingState extends ForgotPassState with LoaderState {}
class ResetPasswordApiSuccessState extends ForgotPassState  {}
class ResetPasswordApiErrorState extends ForgotPassState {}
