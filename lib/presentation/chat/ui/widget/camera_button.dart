import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/common/widget/image_picker_services/image_picker_dialog.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await ImagePickerServices.showOptions(
        context,
        onImageSelected: (xFile) {
          if (xFile != null) {
            chatBloc.add(AddChatImageEvent(file: xFile));
          }
        },
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: SvgPicture.asset(
        MyIcons.cameraIcon,
        color: MyColors.white,
        width: 30.pxH(context),
        height: 30.pxV(context),
      ),
    );
  }
}
