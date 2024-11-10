import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/image_picker_services/image_picker_dialog.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await ImagePickerServices.showOptions(
        context,
        onImageSelected: (xFile) {
          if (xFile == null) {
            ErrorMessages.display(lc(context).noImageSelected);
          } else {
            homeBloc.add(SelectFieldChatImageEvent(file: xFile));
          }
        },
      ),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) =>
            homeBloc.imageUrl != null && homeBloc.imageUrl!.isNotEmpty
                ? UploadedImageWidget(url: homeBloc.imageUrl!)
                : homeBloc.file == null
                    ? const PickNewImageWidget()
                    : SelectedImageWidget(image: homeBloc.file!),
      ),
    );
  }
}

class SelectedImageWidget extends StatelessWidget {
  final File image;
  const SelectedImageWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100.percentWidth(context),
      margin: 20.paddingH(context).copyWith(bottom: 16.pxV(context)),
      decoration: BoxDecoration(
        color: MyColors.secondaryBlue141F48.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10.pxV(context)),
      ),
      child: Image.file(image),
    );
  }
}

class UploadedImageWidget extends StatelessWidget {
  final String url;
  const UploadedImageWidget({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100.percentWidth(context),
      margin: 20.paddingH(context).copyWith(bottom: 16.pxV(context)),
      decoration: BoxDecoration(
        color: MyColors.secondaryBlue141F48.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10.pxV(context)),
      ),
      child: CachedNetworkImage(imageUrl: url),
    );
  }
}

class PickNewImageWidget extends StatelessWidget {
  const PickNewImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.paddingH(context).copyWith(bottom: 12.pxV(context)),
      child: ListTile(
        tileColor: MyColors.secondaryBlue141F48.withOpacity(0.6),
        contentPadding: 20.paddingH(context),
        leading: SvgPicture.asset(
          MyIcons.cameraIcon,
          color: MyColors.blue2575FC,
        ),
        title: TextView(
          lc(context).uploadImage,
          style: myTextStyle.font_16wRegular.copyWith(
            color: MyColors.blue2575FC,
          ),
        ),
        subtitle: Text(
          lc(context).uploadSingleOrMultipleImages,
          style: myTextStyle.font_13w300.copyWith(color: MyColors.blue6B79AD),
        ),
        trailing: SvgPicture.asset(MyIcons.uploadIcon),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
