import 'dart:io';
import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/profile_image_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class UploadImageBtn extends StatefulWidget {
  final String imageUrl;
  final bool isNetworkImage;
  const UploadImageBtn({
    super.key,
    required this.imageUrl,
    required this.isNetworkImage,
  });

  @override
  State<UploadImageBtn> createState() => _UploadImageBtnState();
}

class _UploadImageBtnState extends State<UploadImageBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.pxH(context),
      width: 64.pxH(context),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: ProfileImageWidget(
              imageUrl: widget.imageUrl,
              isNetworkImage: widget.isNetworkImage,
              file: profileBloc.image == null
                  ? homeBloc.loginResponse.file
                  : File(profileBloc.image!.path),
              size: 60,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 24.pxH(context),
              width: 24.pxH(context),
              decoration: const BoxDecoration(
                color: MyColors.blue6C63FF,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 12,
                color: MyColors.whiteFFFFFF,
              ),
            ),
          )
        ],
      ),
    );
  }
}
