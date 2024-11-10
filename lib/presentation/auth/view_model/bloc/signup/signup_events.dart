import 'package:country_picker/country_picker.dart';
import 'package:roboti_app/presentation/auth/model/auth_user.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_event.dart';

abstract class SignupEvents extends AuthEvent {}

class CreateAccountScreenEvent extends SignupEvents {
  final String fName, lName, email, password, confirmPassword;
  String? countryCode;

  CreateAccountScreenEvent({
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.countryCode,
  });
}

class CountrySelectedEvent extends SignupEvents {
  Country country;

  CountrySelectedEvent({required this.country});
}

class SignupOtpEvent extends SignupEvents {
  final String otp;

  SignupOtpEvent({required this.otp});
}

class ResendOtpEvent extends SignupEvents {
  final String fName, lName, email, password, confirmPassword;

  ResendOtpEvent({
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory ResendOtpEvent.fromUser(UserModel user) {
    return ResendOtpEvent(
      fName: user.fName,
      lName: user.lName,
      email: user.email,
      password: user.password,
      confirmPassword: user.confirmPassword,
    );
  }
}

class CreateAccountApiEvent extends SignupEvents {}
