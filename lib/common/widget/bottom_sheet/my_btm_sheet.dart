import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class MyBottomSheet {
  static Future openBottomSheet(
    BuildContext context, {
    required Widget child,
    double? minHieght,
  }) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(19),
          ),
        ),
        builder: (context) => CustomKeyboardAlignmentWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.percentWidth(context),
                padding: 15.paddingV(context),
                child: Center(
                  child: Container(
                    height: 3.pxV(context),
                    width: 62.pxH(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: MyColors.secondaryBlue141F48,
                    ),
                  ),
                ),
              ),
              SizedBox(height: minHieght, child: child),
            ],
          ),
        ),
      );

  static closeBottomSheet() {
    Navigator.pop(GlobalContext.currentContext!);
  }
}

class CustomKeyboardAlignmentWidget extends StatelessWidget {
  final Widget child;
  const CustomKeyboardAlignmentWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(padding: mediaQueryData.viewInsets, child: child);
  }
}
