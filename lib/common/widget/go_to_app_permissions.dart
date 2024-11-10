// ignore_for_file: use_build_context_synchronously

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';

class AppInfo {
  static Future<void> openAppInfoDialog({
    required String message,
    Function? onCloseTap,
    Function? onGoToAppSettingsTapped,
  }) async {
    await showCupertinoDialog(
      context: GlobalContext.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(
          lc(context).alert,
          style: myTextStyle.font_25wRegular,
        ),
        content: Text(message, style: myTextStyle.font_16wRegular),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              if (onCloseTap != null) {
                onCloseTap();
              }
              Navigator.pop(context);
            },
            child: Text(
              lc(context).close,
              style: myTextStyle.font_16wRegular,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              await AppSettings.openAppSettings(asAnotherTask: true);
              // await Future.delayed(const Duration(seconds: 5));
              Navigator.pop(context);
            },
            child: Text(
              lc(context).goToAppSettings,
              style: myTextStyle.font_16wRegular,
            ),
          ),
          // CustomButton(
          //   onTap: () {
          //     if (onCloseTap != null) {
          //       onCloseTap();
          //     }
          //     Navigator.pop(context);
          //   },
          //   buttonWidth: 60,
          //   fillColor: Colors.transparent,
          //   textColor: themeOrange,
          //   buttonText: "Close",
          //   textFontSize: 16.pxV(context),
          //   textFontWeight: FontWeight.w600,
          // ),
          // CustomButton(
          //   onTap: () async {
          //     await AppSettings.openAppSettings(asAnotherTask: true);
          //     // await Future.delayed(const Duration(seconds: 5));
          //     Navigator.pop(context);

          //     if (onGoToAppSettingsTapped != null) {
          //       onGoToAppSettingsTapped();
          //     }
          //   },
          //   buttonWidth: 125,
          //   fillColor: Colors.transparent,
          //   textColor: themeBlue,
          //   buttonText: "Go to App Settings",
          //   textFontSize: 16.pxV(context),
          //   textFontWeight: FontWeight.w600,
          // ),
        ],
      ),
    );
  }
}
