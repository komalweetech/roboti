import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/membership_pop_up.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class SendMessageButton extends StatelessWidget {
  final double size;
  const SendMessageButton({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
      builder: (context, state) => InkWell(
        onTap: () {
          // primaryFocus!.unfocus();
          if (state is MessageResponseAnimatingState) {
            _stopAnimatingMessage(context, state);
          } else if (state is! MessageResponseLoadingState) {
            _sendMessage(context, state);
          }
        },
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            gradient: MyColors.gradient4B3EE1To2575FCTopToBottom,
            borderRadius: BorderRadius.circular(1000),
          ),
          alignment: Alignment.center,
          child: buildIcon(context, state),
        ),
      ),
    );
  }

  Future<void> _stopAnimatingMessage(
    BuildContext context,
    ChatState state,
  ) async {
    chatBloc.add(StopAnimatingGPTResponseEvent());
  }

  Future<void> _sendMessage(
    BuildContext context,
    ChatState state,
  ) async {
    chatBloc.add(ShowLoaderToButtonEvent());
    TrialRequestHandler(
      context: context,
      onAllowed: () {
        if (state is MessageResponseAnimatingState) {
          chatBloc.add(StopAnimatingGPTResponseEvent());
        } else {
          chatBloc.add(SendMessageEvent());
        }
      },
    ).handleTrialRequest(() => chatBloc.add(ResetChatStatesEvent()));
  }

  Widget buildIcon(BuildContext context, ChatState state) {
    if (state is MessageResponseLoadingState) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: CircularProgressIndicator(color: MyColors.white, strokeWidth: 3),
      );
    } else if (state is MessageResponseAnimatingState) {
      return Container(
        height: 18.pxV(context),
        width: 18.pxV(context),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    } else {
      return SvgPicture.asset(
        MyIcons.sendArrowIcon,
        height: 15.pxV(context),
        width: 11.95.pxH(context),
      );
    }
  }
}
