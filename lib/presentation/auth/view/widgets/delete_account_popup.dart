import 'package:flutter/cupertino.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/delete_account/delete_account_events.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class DeleteAccount {
  static deleteAccountPopup() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: GlobalContext.currentContext!,
      builder: (context) => CupertinoAlertDialog(
        title: Text(lc(context).deleteYourAccount),
        content: Text(lc(context).deleteConfirmation),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => authBloc.add(DeleteAccountWithPasswordEvent()),
            child: Text(
              lc(context).delete,
              style: const TextStyle(color: MyColors.red),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => context.pop(),
            child: Text(
              lc(context).cancel,
            ),
          )
        ],
      ),
    );
  }
}
