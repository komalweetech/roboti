import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class CustomCupertinoLoader {
  static Future<void> showLoaderDialog({BuildContext? context}) async {
    return showDialog(
      context: context ?? GlobalContext.currentContext!,
      barrierDismissible: true,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: MyColors.primaryDarkBlue060A19,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: 16.paddingAll(context),
            child: const CupertinoActivityIndicator(
              color: MyColors.white,
              radius: 18,
            ),
          ),
        ),
      ),
    );
  }

  static Widget showLoaderWidget({
    Color bgColor = MyColors.primaryDarkBlue060A19,
    bool center = false,
  }) {
    return center ? Center(child: _loader(bgColor)) : _loader(bgColor);
  }

  static Widget _loader(Color color) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: color, // MyColors.primaryDarkBlue060A19,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: 16.paddingAll(GlobalContext.currentContext!),
      child: const CupertinoActivityIndicator(
        color: MyColors.white,
        radius: 18,
      ),
    );
  }

  static Future<void> dispose() async {
    Navigator.pop(GlobalContext.currentContext!);
  }
}
