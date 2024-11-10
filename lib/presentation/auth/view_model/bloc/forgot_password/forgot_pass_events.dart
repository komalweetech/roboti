import 'package:roboti_app/presentation/auth/view_model/bloc/base_event.dart';

abstract class ForgotPassEvent extends AuthEvent {}

class ForgotPasswordEmailAddedEvent extends ForgotPassEvent {
  final String email;

  ForgotPasswordEmailAddedEvent({required this.email});
}

class ForgotPasswordOtpEvent extends ForgotPassEvent {
  final String otp;

  ForgotPasswordOtpEvent({required this.otp});
}

class ResetPasswordApiEvent extends ForgotPassEvent {
  final String password, confirmPassword;

  ResetPasswordApiEvent({
    required this.confirmPassword,
    required this.password,
  });
}
