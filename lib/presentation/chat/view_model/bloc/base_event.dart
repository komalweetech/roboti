import 'package:share_plus/share_plus.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {}

class ResetChatStatesEvent extends ChatEvent {}

class ResetChatDataEvent extends ChatEvent {}

class ShowLoaderToButtonEvent extends ChatEvent {}

class UnselectChatImageEvent extends ChatEvent {}

class AddChatImageEvent extends ChatEvent {
  XFile file;
  AddChatImageEvent({required this.file});
}

class StopAnimatingGPTResponseEvent extends ChatEvent {}

class ResponseAnimationCompletedEvent extends ChatEvent {}

class GetChatFromHistoryEvent extends ChatEvent {
  final String id;
  GetChatFromHistoryEvent({required this.id});
}

class UpdateChatFromHistoryEvent extends ChatEvent {}
