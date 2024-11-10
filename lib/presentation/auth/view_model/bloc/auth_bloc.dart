import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/auth/model/auth_user.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_handler.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_handler.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_event_handler.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_event_handler.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_events.dart';

AuthBloc authBloc = AuthBloc(user: UserModel.initialState());

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserModel user;

  AuthBloc({required this.user}) : super(AuthInitialState()) {
    on<LoginEvents>(LoginHandler().loginHandler);
    on<SignupEvents>(SignUpHandler().signupHandler);
    on<ForgotPassEvent>(ForgotPassHandler().forgotPassHandler);
    on<DeleteAccountEvent>(DeleteAccountHandler().deleteAccountHandler);
  }
}
