import 'package:roboti_app/presentation/auth/view_model/bloc/base_event.dart';

abstract class LoginEvents extends AuthEvent {}

class GoogleLoginEvent extends LoginEvents {}

class AppleLoginEvent extends LoginEvents{}

class LoginButtonPressEvent extends LoginEvents {
  final String email;
  final String password;

  LoginButtonPressEvent({
    required this.email,
    required this.password,
  });
}
