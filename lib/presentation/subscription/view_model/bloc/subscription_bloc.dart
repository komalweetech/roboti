import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roboti_app/presentation/subscription/models/trial_model.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events_handler.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_states.dart';

final SubscriptionBloc subscriptionBloc = SubscriptionBloc(
  allPackages: [],
  selectedPackage: null,
  trialModel: null,
  timer: null,
  showPlans: false,
  recentSubscriptionExpiryDate: "",
);

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  List<Package> allPackages;
  Package? selectedPackage;
  TrialModel? trialModel;
  Timer? timer;
  bool showPlans;
  String recentSubscriptionExpiryDate = "";

  SubscriptionBloc({
    required this.allPackages,
    required this.selectedPackage,
    required this.trialModel,
    required this.timer,
    required this.showPlans,
    required this.recentSubscriptionExpiryDate,
  }) : super(SubscriptionInitialState()) {
    on<SubscriptionEvent>(SubscriptionEventsHandler().subscriptionHanlder);
  }

  void resetTimer() {
    timer?.cancel();
    timer = null;
  }
}
