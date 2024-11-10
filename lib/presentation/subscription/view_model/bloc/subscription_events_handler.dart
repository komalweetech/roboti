// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/repo/profile_repo.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_states.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/presentation/subscription/view_model/repo/repo.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

class SubscriptionEventsHandler {
  final _purchaseService = PurchaseService();
  final _profileRepo = ProfileRepo();

  FutureOr<void> subscriptionHanlder(
    SubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (event is InitializeSubscriptionEvent) {
      await _init(event, emit);
    } else if (event is PurchaseSubscriptionEvent) {
      await _purchaseSubscription(event, emit);
    } else if (event is RestoreSubscriptionEvent) {
      await _restoreSubscription(event, emit);
    } else if (event is GetSubscriptionPlansEvent) {
      await _getPackages(event, emit);
    } else if (event is ShowSubcriptionPopupEvent) {
      await _showSubscriptionEvent(event, emit);
    } else if (event is ResetSubscriptionStatesEvent) {
      emit(SubscriptionInitialState());
    } else if (event is UpdateSubscriptionStatusEvent) {
      await _updateSubscriptiounStatus(event, emit);
    } else if (event is LoadStatusEvent) {
      await _loadStatusStateFire(event, emit);
    }
  }

  Future<void> _loadStatusStateFire(
    LoadStatusEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(LoadSubscriptionstatusState());
  }

  Future<void> _updateSubscriptiounStatus(
    UpdateSubscriptionStatusEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    await updateFreeTrialStatus();

    const duration = Duration(seconds: 20);

    if (Platform.isAndroid) {
      subscriptionBloc.timer ??= Timer.periodic(duration, (time) async {
        await updateFreeTrialStatus();
      });
      return subscriptionBloc.emit(SubscriptionExpiryUpdated());
    }

    if (event.forceUpdate) {
      await _updateSubcriptionInfo(emit);
    } else if (event.startTimer) {
      subscriptionBloc.timer ??= Timer.periodic(duration, (time) async {
        await updateFreeTrialStatus();
        await _updateSubcriptionInfo(emit);
      });
    }
  }

  Future<void> updateFreeTrialStatus() async {
    subscriptionBloc.trialModel = await _profileRepo.getUserTrialBalance();
    String msg =
        "${subscriptionBloc.trialModel!.toString()} ${subscriptionBloc.timer.toString()}";
    LogManager.log(msg: msg, head: 'From Init');
    if (subscriptionBloc.trialModel!.isFreeUser) {
      subscriptionBloc.emit(SubscriptionExpiryUpdated());
    }
  }

  Future<bool> _updateSubcriptionInfo(Emitter<SubscriptionState> emit) async {
    if (subscriptionBloc.trialModel!.isFreeUser) return false;

    LogManager.log(
      head: 'From Init',
      msg: "Subscription Status Update Event Handled",
    );

    try {
      await Purchases.syncPurchases();
    } catch (e) {
      LogManager.log(
        head: 'ERROR',
        msg: "Purchases.syncPurchases() subscription_event_handler.dart",
      );
    }

    CustomerInfo info = await _purchaseService.getSubscriptionInfo();

    homeBloc.loginResponse.updatePkgInfoFromRevenueCat(info: info);
    subscriptionBloc.emit(SubscriptionExpiryUpdated());

    if (info.latestExpirationDate != null &&
        subscriptionBloc.trialModel?.trialLimit != 0) {
      subscriptionBloc.trialModel?.trialLimit =
          await _profileRepo.resetTrialCounter();
    }

    return info.latestExpirationDate != null;
  }

  Future<void> _showSubscriptionEvent(
    ShowSubcriptionPopupEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    primaryFocus!.unfocus();
    if (event.showPopup) {
      subscriptionBloc.showPlans = true;
      emit(SubscriptionDialogShowState());
    } else {
      subscriptionBloc.showPlans = false;
      emit(SubscriptionDialogHideState());
    }
  }

  Future<void> _init(
    InitializeSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      await _purchaseService.init();
    } catch (e) {
      ErrorMessages.display(e.toString(), durationInMS: 4000);
    }
  }

  Future<void> _getPackages(
    GetSubscriptionPlansEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (subscriptionBloc.state is! SubscriptionSuccessState ||
        subscriptionBloc.allPackages.isEmpty) {
      emit(SubscriptionPlanLoadingState());
      try {
        List<Package>? availablePackages = await _purchaseService.getPackages();
        if (availablePackages == null) {
          ErrorMessages.display(lcGlobal.noSubscriptionPlansFound);
          return emit(SubscriptionPlanErrorState());
        } else {
          subscriptionBloc.allPackages = availablePackages;
          emit(SubscriptionPlanSuccessState());
        }
      } catch (e) {
        ErrorMessages.display(e.toString(), durationInMS: 4000);
        emit(SubscriptionPlanErrorState());
      }
    }
  }

  Future<void> _purchaseSubscription(
    PurchaseSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    Package? package = subscriptionBloc.selectedPackage;

    if (package == null) {
      ErrorMessages.display(lcGlobal.pleaseSelectAPaymentPackage);
      return emit(SubscriptionErrorState());
    }
    try {
      emit(SubscriptionLoadingState());
      CustomCupertinoLoader.showLoaderDialog();
      final result = await _purchaseService.purchasePackage(package);
      if (result) {
        await _purchaseService.udpateUserPurchase();
        await getIt<SharedPrefsManager>().saveUser(homeBloc.loginResponse);
        CustomCupertinoLoader.dispose();
        subscriptionBloc.trialModel?.trialLimit =
            await _profileRepo.resetTrialCounter();
        LogManager.log(
          head: 'FROM SUBCRIBE USER',
          msg: '${subscriptionBloc.trialModel}',
        );

        emit(SubscriptionSuccessState());
      } else {
        CustomCupertinoLoader.dispose();
        ErrorMessages.display(lcGlobal.failedToSubscribe);
        return emit(SubscriptionErrorState());
      }
    } catch (e) {
      CustomCupertinoLoader.dispose();
      ErrorMessages.display(e.toString());
      emit(SubscriptionErrorState());
    }
  }

  Future<void> _restoreSubscription(
    RestoreSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      emit(SubscriptionLoadingState());

      final result = await _purchaseService.restorePurchases();

      if (result) {
        emit(SubscriptionSuccessState());
      }
    } catch (e) {
      emit(SubscriptionErrorState());
    }
  }
}
