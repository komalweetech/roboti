// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/repo/profile_repo.dart';
import 'package:roboti_app/presentation/subscription/models/trial_model.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/utils/shared_pref_manager/pref_keys.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';
import 'package:roboti_app/utils/extensions/date_time.dart';

class TrialRequestHandler {
  final BuildContext context;
  final Function onAllowed;

  TrialRequestHandler({required this.context, required this.onAllowed});
  final ProfileRepo _profileRepo = ProfileRepo();

  void handleTrialRequest(Function() onShowPopup) async {
    // onAllowed();
    subscriptionBloc.trialModel = await _profileRepo.getUserTrialBalance();

    if (subscriptionBloc.trialModel != null) {
      TrialModel bal = subscriptionBloc.trialModel!;
      subscriptionBloc.add(UpdateSubscriptionStatusEvent(forceUpdate: true));
      bal.isPlanActive = homeBloc.loginResponse.isPlanActive;
      await _executeTask(bal, onShowPopup);
    }
  }

  Future<void> _executeTask(TrialModel bal, Function() onShowPopup) async {
    if (Platform.isAndroid) {
      onAllowed();
    } else {
      if (bal.isFreeUser) {
        onAllowed();
      } else if (!trailLimitExceeded(bal.trialLimit)) {
        // If the person is a new user and have trial limits remaining
        bal.trialLimit = await _profileRepo.updateTrialCounter();
        onAllowed();
      } else {
        // The user has an unexpired preimium membership
        if (bal.isPlanActive) {
          onAllowed();
        } else {
          onShowPopup();
          subscriptionBloc.add(ShowSubcriptionPopupEvent(showPopup: true));
        }
        // } else {}
      }
    }
  }

  bool trailLimitExceeded(int trialLimit) => trialLimit == 0;

  static bool isPremium() =>
      homeBloc.loginResponse.planExpireAt
          ?.isAtSameMomentOrIsAfter(DateTime.now()) ??
      false;

  static bool isExpired() =>
      homeBloc.loginResponse.planExpireAt
          ?.isAtSameMomentOrIsBefore(DateTime.now()) ??
      false;

  static bool isStarter() =>
      getIt<SharedPrefsManager>().getData(PrefKeys.trialLimit) == 0;
}
