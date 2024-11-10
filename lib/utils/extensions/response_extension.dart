// ignore_for_file: use_build_context_synchronously

import 'package:roboti_app/presentation/auth/view/screens/sign_in.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

extension InvalidTokenExtension on Map<String, dynamic> {
  bool hasInvalidToken() {
    return containsKey('status') &&
        this['status'] != null &&
        this['status'] == 401;
  }

  void onInvalidToken() async {
    // MySnackbar.showSnackbar(this['message']);
    SharedPrefsManager prefManager = getIt<SharedPrefsManager>();
    await prefManager.removeUserToken();
    subscriptionBloc.resetTimer();
    GlobalContext.currentContext!.pushNamedAndRemoveUntil(SignInScreen.route);
  }
}
