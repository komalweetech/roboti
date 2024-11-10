abstract class ChatState {}

class ChatInitialState extends ChatState {}

// Message States
class MessageSentSuccessState extends ChatState {}

class MessageSentErrorState extends ChatState {}

class MessageResponseErrorState extends ChatState {}

class MessageResponseSuccessState extends ChatState {}

class MessageResponseAnimatingState extends ChatState {}

class MessageResponseAnimationPauseState extends ChatState {}

class MessageResponseLoadingState extends ChatState {}

class ChatImageUnselectedState extends ChatState {}

class ChatImageSelectedState extends ChatState {}
