// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/bottom_sheet/my_btm_sheet.dart';
import 'package:roboti_app/common/widget/go_to_app_permissions.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class ImagePickerServices {
  static Future<void> showOptions(
    BuildContext context, {
    required Function(XFile?) onImageSelected,
  }) async {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        color: Colors.transparent,
        child: CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              context.pop();
            },
            child: Text(
              lc(context).cancel,
            ),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () async => await _captureImageFromCamera(
                context: context,
                onImageSelected: onImageSelected,
              ),
              child: Text(
                lc(context).takePhoto,
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async => await _pickImageFromPhone(
                context: context,
                onImageSelected: onImageSelected,
              ),
              child: Text(
                lc(context).choosePhoto,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static _pickImageFromPhone({
    required Function(XFile?) onImageSelected,
    required BuildContext context,
  }) async {
    bool allowed = await isAllowed(
      Platform.isAndroid ? Permission.accessMediaLocation : Permission.photos,
      context,
    );

    if (allowed) {
      MySnackbar.showSnackbar(
        "Permission for ${Platform.isAndroid ? "media access" : "photos"} allowed",
      );
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 30,
      );
      MyBottomSheet.closeBottomSheet();
      onImageSelected(image);
    }
  }

  static _captureImageFromCamera({
    required Function(XFile?) onImageSelected,
    required BuildContext context,
  }) async {
    bool allowed = true;

    // if (Platform.isAndroid) {
    allowed = await isAllowed(Permission.camera, context);
    // }

    if (allowed) {
      MySnackbar.showSnackbar(lc(context).permissionForMediaAccessAllowed);
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
      );

      MyBottomSheet.closeBottomSheet();

      onImageSelected(image);
    }
  }

  static Future<bool> isAllowed(Permission per, BuildContext context) async {
    PermissionStatus permission = await per.status;
    permission = await per.request();

    if (permission.isPermanentlyDenied) {
      await AppInfo.openAppInfoDialog(
        message: lc(context).theAppNeedsContactPermissionForFurtherProceedings,
      );
    }

    return await per.isGranted || await per.isLimited;
  }
}
