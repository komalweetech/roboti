import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';

class AnimatedGPTResponseEffect extends StatefulWidget {
  final ChatModel chat;
  final Duration drutaion;
  final Function() onFinished;
  final ChatState state;
  const AnimatedGPTResponseEffect({
    super.key,
    required this.drutaion,
    required this.chat,
    required this.onFinished,
    required this.state,
  });

  @override
  State<AnimatedGPTResponseEffect> createState() =>
      _AnimatedGPTResponseEffectState();
}

class _AnimatedGPTResponseEffectState extends State<AnimatedGPTResponseEffect> {
  @override
  void initState() {
    animate();
    super.initState();
  }

  void animate() async {
    if (widget.chat.message == chatBloc.chat.last.message &&
        !widget.chat.fromUser) {
      List<String> values = widget.chat.message.split(" ");
      int index = 0;
      widget.chat.timer = Timer.periodic(
        widget.drutaion,
        (timer) {
          if (!pause && index < values.length) {
            widget.chat.animatedMessages =
                "${widget.chat.animatedMessages}${values[index]} ";
            index++;
            if (mounted) setState(() {});

            if (widget.chat.animatedMessages.length >=
                widget.chat.message.length) {
              widget.chat.timer!.cancel();
              widget.onFinished();
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (pause) {
          widget.chat.timer!.cancel();
          widget.chat.timer = null;
        }
      },
      builder: (context, state) => Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextView(
            widget.chat.animatedMessages,
            style: myTextStyle.font_16wRegular,
          ),
          if (widget.chat.animatedMessages.length <= widget.chat.message.length)
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: MyColors.white,
              ),
            ),
        ],
      ),
    );
  }

  bool get pause => widget.state is MessageResponseAnimationPauseState;
}
