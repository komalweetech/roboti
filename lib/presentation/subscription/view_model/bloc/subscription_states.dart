import 'package:roboti_app/base_redux/base_state.dart';

abstract class SubscriptionState {}

class SubscriptionExpiryUpdated extends SubscriptionState {}

class SubscriptionInitialState extends SubscriptionExpiryUpdated {}

class SubscriptionLoadingState extends SubscriptionExpiryUpdated {}

class LoadSubscriptionstatusState extends SubscriptionState with LoaderState {}

class SubscriptionErrorState extends SubscriptionExpiryUpdated {}

class SubscriptionSuccessState extends SubscriptionExpiryUpdated {}

class SubscriptionPlanLoadingState extends SubscriptionExpiryUpdated {}

class SubscriptionPlanSuccessState extends SubscriptionExpiryUpdated {}

class SubscriptionPlanErrorState extends SubscriptionExpiryUpdated {}

class SubscriptionDialogShowState extends SubscriptionExpiryUpdated {}

class SubscriptionDialogHideState extends SubscriptionExpiryUpdated {}
