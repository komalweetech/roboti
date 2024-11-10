import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';

abstract class LoginStates extends AuthState {}

class LoginApiCallState extends LoginStates {}

class GoogleLoginLoadingState extends LoginStates {}

class GoogleLoginSuccessState extends LoginStates {}

class GoogleLoginErrorState extends LoginStates {}

class AppleLoginLoadingState extends LoginStates{}

class AppleLoginSuccessState extends LoginStates{}

class AppleLoginErrorState extends LoginStates{}

class LoginButtonPressLoadingState extends LoginStates with LoaderState {}

class LoginButtonPressSuccessState extends LoginStates {}

class LoginButtonPressErrorState extends LoginStates {}

// Otp not verified State
class OtpNotVerifiedState extends LoginStates {}
