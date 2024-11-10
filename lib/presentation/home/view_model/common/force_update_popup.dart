import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdatePopup {
  static show() async {
    final context = GlobalContext.currentContext!;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: CupertinoAlertDialog(
          title: Text(lc(context).newVersionAvailable),
          content: Text(lc(context).updateAppMsg),
          actions: [
            CupertinoDialogAction(
              onPressed: () async => await launchUrl(
                Uri.parse(ForceUpdateUrls.getAppUrl),
              ),
              child: Text(lc(context).updateTheApp),
            ),
            // CupertinoDialogAction(
            //   onPressed: () {
            //     exit(0);
            //   },
            //   child: Text(lc(context).closeTheApp),
            // )
          ],
        ),
      ),
    );
  }
}
