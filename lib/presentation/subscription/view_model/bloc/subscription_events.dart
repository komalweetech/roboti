abstract class SubscriptionEvent {}

class ShowSubcriptionPopupEvent extends SubscriptionEvent {
  bool showPopup;

  ShowSubcriptionPopupEvent({required this.showPopup});
}

class GetSubscriptionPlansEvent extends ShowSubcriptionPopupEvent {
  GetSubscriptionPlansEvent() : super(showPopup: false);
}

class PurchaseSubscriptionEvent extends SubscriptionEvent {}

class RestoreSubscriptionEvent extends SubscriptionEvent {}

class InitializeSubscriptionEvent extends SubscriptionEvent {}

class ResetSubscriptionStatesEvent extends SubscriptionEvent {}

class UpdateSubscriptionStatusEvent extends SubscriptionEvent {
  final bool forceUpdate;
  final bool startTimer;

  UpdateSubscriptionStatusEvent({
    this.forceUpdate = false,
    this.startTimer = false,
  });
}

class LoadStatusEvent extends SubscriptionEvent {}
