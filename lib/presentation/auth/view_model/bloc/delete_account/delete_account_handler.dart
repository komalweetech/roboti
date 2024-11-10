import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_states.dart';
import 'package:roboti_app/presentation/auth/view_model/repo/auth_repo.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class DeleteAccountHandler {
  final AuthRepo _authRepo = AuthRepo();

  FutureOr<void> deleteAccountHandler(
    DeleteAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event is DeleteAccountWithPasswordEvent) {
      await _deleteAccountEvent(event, emit);
    }
  }

  Future<void> _deleteAccountEvent(
    DeleteAccountWithPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(DeleteAccountLoadingState());
    CustomCupertinoLoader.showLoaderDialog();
    Map<String, dynamic> response = await _authRepo.deleteAccount(
      userID: homeBloc.loginResponse.id!,
    );

    if (response['data'] == null || response['data'].isEmpty) {
      CustomCupertinoLoader.dispose();
      ErrorMessages.display(response['message']);
      GlobalContext.currentContext!.pop();

      emit(DeleteAccountErrorState());
    } else {
      MySnackbar.showSnackbar(response['message']);
      GlobalContext.currentContext!.pushNamedAndRemoveUntil(SignInScreen.route);
      emit(DeleteAccountSuccessState());
    }
  }
}
