import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/chat/ui/widget/camera_button.dart';
// import 'package:roboti_app/presentation/chat/ui/widget/camera_button.dart';
// import 'package:roboti_app/presentation/chat/ui/widget/camera_button.dart';
import 'package:roboti_app/presentation/chat/ui/widget/send_message_button.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class MessageField extends StatefulWidget {
  final Duration animationDuraiton;
  final Curve animationCurve;
  final Function() onTap;
  final Function(String) onChanged;
  final double animatedWidth;
  const MessageField({
    super.key,
    this.animationDuraiton = const Duration(milliseconds: 300),
    this.animationCurve = Curves.fastEaseInToSlowEaseOut,
    required this.onTap,
    required this.onChanged,
    required this.animatedWidth,
  });

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  void initState() {
    chatBloc.msgController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    chatBloc.msgController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is MessageResponseLoadingState,
          child: SafeArea(
            child: Container(
              padding: 20.paddingH(context).copyWith(
                    bottom: 16.pxV(context),
                    top: 10.pxV(context),
                  ),
              width: 100.percentWidth(context),
              color: MyColors.primaryDarkBlue060A19,
              child: Column(
                children: [
                  if (chatBloc.image != null)
                    SelectedImageWidget(
                      image: chatBloc.image!,
                      onCloseTap: () => chatBloc.add(UnselectChatImageEvent()),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CameraButton(),
                      7.hSpace(context),
                      Expanded(child: _msgField()),
                      SizedBox.fromSize(
                        child: SingleChildScrollView(
                          child: AnimatedContainer(
                            width: widget.animatedWidth,
                            duration: widget.animationDuraiton,
                            curve: widget.animationCurve,
                            margin: 5.4.paddingLeft(context),
                            child:
                                SendMessageButton(size: widget.animatedWidth),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _msgField() {
    return TextField(
      controller: chatBloc.msgController,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      style: myTextStyle.font_16wRegular.textColor(MyColors.whiteC1C1C1),
      keyboardType: TextInputType.multiline,
      cursorColor: MyColors.whiteFFFFFF,
      decoration: InputDecoration(
        contentPadding: 15.paddingH(context).copyWith(
              top: 12.3.pxV(context),
              bottom: 14.3.pxV(context),
            ),
        isDense: true,
        hintText: lc(context).message,
        hintStyle: myTextStyle.font_16wRegular.textColor(MyColors.whiteC1C1C1),
        focusColor: MyColors.whiteFFFFFF,
        border: border(),
        focusedBorder: border(),
        enabledBorder: border(),
        disabledBorder: border(),
        focusedErrorBorder: border(),
        constraints: BoxConstraints(
          maxHeight: 100,
          maxWidth: 100.percentWidth(context),
        ),
      ),
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  InputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.pxV(context)),
      borderSide: const BorderSide(color: MyColors.whiteFFFFFF, width: 1),
    );
  }
}

class SelectedImageWidget extends StatelessWidget {
  final File image;
  final Function() onCloseTap;
  const SelectedImageWidget({
    super.key,
    required this.image,
    required this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 100.percentWidth(context),
      margin: 16.paddingBottom(context),
      decoration: BoxDecoration(
        color: MyColors.secondaryBlue141F48,
        borderRadius: BorderRadius.circular(08.pxV(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 25.percentWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(08.pxV(context)),
                bottomLeft: Radius.circular(08.pxV(context)),
              ),
              color: Colors.black,
            ),
            child: Image.file(image),
          ),
          12.hSpace(context),
          Expanded(
            child: TextView(
              // image.path.split("/").last,
              lc(context).imageSelected,
              style: myTextStyle.font_12w400,
              maxLine: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          12.hSpace(context),
          InkWell(
            onTap: onCloseTap,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(08.pxV(context)),
              bottomRight: Radius.circular(08.pxV(context)),
            ),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(08.pxV(context)),
                  bottomRight: Radius.circular(08.pxV(context)),
                ),
              ),
              padding: 16.paddingH(context),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
