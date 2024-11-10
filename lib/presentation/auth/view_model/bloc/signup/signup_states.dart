import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';

abstract class SignupStates extends AuthState {}

class CountrySelectedState extends SignupStates {}

class CreateNewAccountState extends SignupStates {}

// Get OTP States
class CreateAccountApiLoaderState extends SignupStates with LoaderState{}
class CreateAccountApiSuccessState extends SignupStates {}
class CreateAccountApiErrorState extends SignupStates {}

// Verify OTP States
class VerifyOtpLoadingState extends SignupStates with LoaderState{}
class VerifyOtpSuccessState extends SignupStates{}
class VerifyOtpErrorState extends SignupStates{}

