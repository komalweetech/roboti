import 'package:roboti_app/presentation/auth/view_model/bloc/base_event.dart';

abstract class DeleteAccountEvent extends AuthEvent {}

class DeleteAccountWithPasswordEvent extends DeleteAccountEvent {}
