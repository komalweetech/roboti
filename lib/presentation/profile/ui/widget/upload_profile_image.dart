// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/image_picker_services/image_picker_dialog.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/ui/widget/upload_image_btn.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class UploadProfileImageWidget extends StatefulWidget {
  const UploadProfileImageWidget({super.key});

  @override
  State<UploadProfileImageWidget> createState() =>
      _UploadProfileImageWidgetState();
}

class _UploadProfileImageWidgetState extends State<UploadProfileImageWidget> {
  bool isNetworkImage = false;

  @override
  void initState() {
    profileBloc.image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.paddingH(context),
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        splashColor: Colors.transparent,
        onTap: () async {
          primaryFocus!.unfocus();
          await ImagePickerServices.showOptions(
            context,
            onImageSelected: (xFile) {
              if (xFile != null) {
                profileBloc.image = xFile;
                isNetworkImage = false;
                setState(() {});
              }
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UploadImageBtn(
              imageUrl: isImageEmpty && homeBloc.file == null
                  ? profileBloc.image?.path ?? ""
                  : homeBloc.loginResponse.imageUrl,
              isNetworkImage: isNetworkImage,
            ),
            Expanded(
              child: TextView(
                lc(context).uploadProfilePicture,
                // (isImageEmpty && homeBloc.file == null
                //         ? profileBloc.image == null ||
                //                 profileBloc.image!.path.isEmpty
                //             ? lc(context).uploadProfilePicture
                //             : profileBloc.image!.path
                //         : homeBloc.loginResponse.imageUrl)
                //     .split("/")
                //     .last,
                style: myTextStyle.font_16wRegular,
                padding: 13.paddingH(context),
                maxLine: 2,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isImageEmpty =>
      homeBloc.loginResponse.imageUrl.isEmpty ||
      homeBloc.loginResponse.imageUrl.toLowerCase() == "null";
}
