import 'package:roboti_app/base_redux/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';

abstract class DeleteAccountState extends AuthState {}

class DeleteAccountLoadingState extends DeleteAccountState with LoaderState {}

class DeleteAccountSuccessState extends DeleteAccountState {}

class DeleteAccountErrorState extends DeleteAccountState {}
