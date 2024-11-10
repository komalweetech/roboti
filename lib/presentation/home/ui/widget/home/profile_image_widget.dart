import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_states.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;
  final double size;
  final File? file;

  const ProfileImageWidget({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.size = 60.8,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: homeBloc,
      builder: (context, homeState) => BlocBuilder<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        builder: (context, profileState) => Container(
          height: size.pxH(context),
          width: size.pxH(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.pxV(context)),
            color: MyColors.lightBlue0D142F,
          ),
          child: isImageEmpty
              ? const Icon(
                  Icons.person_rounded,
                  color: MyColors.white585f78,
                  size: 40,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16.pxV(context)),
                  child: isNetworkImage
                      ? Text(
                          "Network Image",
                          style: myTextStyle.font_12w400,
                        )
                      : file != null
                          ? Image.file(file!, fit: BoxFit.cover)
                          : CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              // errorWidget: (context, url, error) => const Icon(
                              //   Icons.person_rounded,
                              //   color: MyColors.white585f78,
                              //   size: 40,
                              // ),
                            ),
                ),
        ),
      ),
    );
  }

  bool get isImageEmpty => imageUrl.isEmpty || imageUrl.toLowerCase() == "null";
}
