import 'package:flutter/material.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';

class MySnackbar {
  static Future showSnackbar(
    String msg, {
    int durationMS = 1500,
    Color bgColor = Colors.black,
    Color msgColor = Colors.white,
    TextStyle? msgStyle,
  }) async {
    ScaffoldMessenger.of(GlobalContext.currentContext!).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: durationMS),
        content: Text(msg, style: msgStyle ?? myTextStyle.font_16wRegular
            // TextStyle(
            //   color: msgColor,
            // ),
            ),
        backgroundColor: bgColor,
      ),
    );
  }
}
