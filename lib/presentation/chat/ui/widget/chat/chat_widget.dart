import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/presentation/chat/ui/widget/chat/animated_response_widget.dart';
import 'package:roboti_app/presentation/chat/ui/widget/chat/my_image_widget.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel chat;
  final Function() onFinished;
  final Function(int, bool)? onNext;
  final bool animateText;
  final ChatState state;
  final bool fromHistory;
  const ChatWidget({
    super.key,
    required this.chat,
    required this.onFinished,
    required this.onNext,
    required this.animateText,
    required this.state,
    required this.fromHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 71.4.percentWidth(context),
        padding:
            (chat.type == ChatType.img ? 0 : 15).paddingH(context).copyWith(
                  top: 12.pxV(context),
                  bottom: 12.pxV(context),
                ),
        margin: 22.paddingLeft(context).copyWith(bottom: 12.pxV(context)),
        decoration: BoxDecoration(
          color: chat.fromUser ? MyColors.grey4E5067 : null,
          borderRadius: BorderRadius.circular(20.pxV(context)),
          gradient:
              chat.fromUser ? null : MyColors.gradient0014FFTo00E5FFTopToBottom,
        ),
        child: SelectionArea(child: _showMessage()),
      ),
    );
  }

  Widget _showMessage() {
    if (chat.type == ChatType.img) {
      return ImageMsgWidget(chat: chat, fromHistory: fromHistory);
    } else if (animateText) {
      return AnimatedGPTResponseEffect(
        chat: chat,
        drutaion: const Duration(milliseconds: 60),
        onFinished: onFinished,
        state: state,
      );
    } else {
      return TextView(chat.message, style: myTextStyle.font_16wRegular);
    }
  }
}
