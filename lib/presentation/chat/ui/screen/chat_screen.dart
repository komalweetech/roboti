import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/presentation/chat/ui/widget/chat/chat_widget.dart';
import 'package:roboti_app/presentation/chat/ui/widget/message_field.dart';
import 'package:roboti_app/presentation/chat/ui/widget/no_chat_widget.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_events.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_popup_screen.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "chat_screen";
  final bool fromHistory;
  const ChatScreen({
    Key? key,
    this.fromHistory = false,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  bool shouldDisplaySendButton = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: SubscriptionPopStackedWidget(
        onInit: () {
          if (!widget.fromHistory) {
            chatBloc.add(ResetChatDataEvent());
          }
        },
        onDispose: () {
          scrollController.dispose();
          if (widget.fromHistory) {
            chatBloc.add(UpdateChatFromHistoryEvent());
          } else {
            historyBloc.add(CreateChatHistoryEvent());
          }
        },
        appbar: const MyAppBar(
          title: MyLogoWidget(),
          leadingWidget: MyBackButton(),
        ),
        screen: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (dontAllowDisplayButton(state)) {
              setState(() => shouldDisplaySendButton = false);
            }
          },
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (chatBloc.chat.isNotEmpty) ...[
                Flexible(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatBloc.chat.length,
                    itemBuilder: (context, index) {
                      ChatModel chat =
                          chatBloc.chat[chatBloc.chat.length - 1 - index];
                      return ChatWidget(
                        chat: chat,
                        onFinished: () =>
                            chatBloc.add(ResponseAnimationCompletedEvent()),
                        state: state,
                        onNext: (p0, p1) {},
                        animateText: !chat.fromUser && chat.animateMessage,
                        fromHistory: widget.fromHistory,
                      );
                    },
                  ),
                ),
              ] else
                const NoChatWidget(),
              MessageField(
                onTap: () {},
                onChanged: (val) => changeSendBtnVisibility(val),
                animatedWidth: shouldDisplaySendButton ? 48.64.pxV(context) : 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeSendBtnVisibility(String val) {
    if (val.isNotEmpty && !shouldDisplaySendButton) {
      setState(() => shouldDisplaySendButton = true);
    }
    if (val.isEmpty) {
      setState(() => shouldDisplaySendButton = false);
    }
  }

  bool dontAllowDisplayButton(state) =>
      state is MessageResponseSuccessState ||
      state is MessageResponseAnimationPauseState ||
      state is MessageResponseErrorState ||
      state is ChatImageUnselectedState;

  // List<ChatState> dontAllowBtnsStates = [
  //   MessageResponseSuccessState(),
  //   MessageResponseAnimationPauseState(),
  //   MessageResponseErrorState(),
  //   ChatImageUnselectedState()
  // ];
}
