import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/presentation/subscription/view_model/repo/request_parser.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:roboti_app/utils/logs/log_manager.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

const _entitleMentKey = 'premium';

class PurchaseService {
  final SubscriptionRequestParser _parser = SubscriptionRequestParser();
  final NetworkApiService _services = NetworkApiService();
  List<Package>? packages;

  bool? _isSubscribed;
  bool get isSubscribed => _isSubscribed ?? false;

  EntitlementInfo? customerEntitlementInfo;

  Future<void> init() async {
    try {
      if (Platform.isAndroid) {
        // TODO: Configure purchases for Android platform
      } else if (Platform.isIOS) {
        await Purchases.configure(
          PurchasesConfiguration(ApiKeys.revenueCatAppleKey!),
        );
      }
      // listener whenever there's a change in customer status
      await createListener();
      // return packages;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createListener() async {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      // customerInfo = await Purchases.getCustomerInfo();
      final entitlement = customerInfo.entitlements.all[_entitleMentKey];
      final subscriptionStatus = entitlement?.isActive;
      customerEntitlementInfo = entitlement;

      _isSubscribed = subscriptionStatus;
    });
  }

  Future<void> disposeListener() async {
    Purchases.removeCustomerInfoUpdateListener((customerInfo) {});
  }

  Future<CustomerInfo> getSubscriptionInfo() async {
    return await Purchases.getCustomerInfo();
  }

  Future<List<Package>?> getPackages() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      // return packages = offerings.current?.availablePackages;
      packages = offerings.current?.availablePackages ?? [];
      return packages;
    } catch (e) {
      // rethrow;
      return null;
    }
  }

  Future<String> setUserIdAsMetadata() async {
// final customerInfo = await Purchases.;
    Offerings? offerings;
    Offering? current;
    CustomerInfo? customerInfo;

    try {
      offerings = await Purchases.getOfferings();
      customerInfo = await Purchases.getCustomerInfo();
    } catch (e) {
      offerings = null;
    }

    if (offerings != null) {
      current = offerings.current;
      if (current != null) {
        String userId = getIt<SharedPrefsManager>().getUserId();
        if (userId.isNotEmpty) {
          current = current.copyWith(metadata: {"user_id": userId});
        } else {
          LogManager.log(head: 'OFFERINGS', msg: 'No user id found');
        }
      }
    }

    offerings = await Purchases.getOfferings();
    return offerings.current?.metadata.toString() ?? "";
    // return offerings.current?.getMetadataString("user_id", "nothing") ?? "";
  }

  Future<bool> purchasePackage(Package package) async {
    // final allowed = await Purchases.getCustomerInfo();
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      await Purchases.syncPurchases();

      customerEntitlementInfo = customerInfo.entitlements.all[_entitleMentKey];

      return _entitleMentIsActive(customerInfo);
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      return _entitleMentIsActive(customerInfo);
    } on PlatformException {
      rethrow;
    }
  }

  bool _entitleMentIsActive(CustomerInfo customerInfo) {
    LogManager.log(
      msg: customerInfo.entitlements.all[_entitleMentKey].toString(),
    );
    // customerInfo.entitlements.all[_entitleMentKey]?.expirationDate;
    return customerInfo.entitlements.all[_entitleMentKey]?.isActive ?? false;
  }

  Future<void> udpateUserPurchase() async {
    try {
      if (subscriptionBloc.selectedPackage != null) {
        Package package = subscriptionBloc.selectedPackage!;
        int type = _getPkgType(package);

        String expiry = customerEntitlementInfo!.expirationDate!;

        String requestBody = _parser.getUpdatePurchaseBody(expiry, type);

        Map<String, dynamic> response = {};

        response = await _services.getPostApiResponse(
          ApiUrls.subscriptionUrl,
          requestBody,
        );
        subscriptionBloc.add(UpdateSubscriptionStatusEvent(forceUpdate: true));
        // var info = await PurchaseService().getSubscriptionInfo();
        // homeBloc.loginResponse.updatePkgInfoFromRevenueCat(info: info);

        print(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> udpateUserExpiry(String? date, {bool fromSplash = false}) async {
  //   try {
  //     if (subscriptionBloc.selectedPackage != null || fromSplash) {
  //       String requestBody = _parser.getUpdateExpiryReqBody(date.toString());

  //       Map<String, dynamic> response = {};

  //       response = await _services.getPostApiResponse(
  //         ApiUrls.subscriptionUrl,
  //         requestBody,
  //       );

  //       // if (response['status'] >= 300) {
  //       //   ErrorMessages.display(response['message']);
  //       // } else {
  //       homeBloc.loginResponse.updatePkgInfo(response);
  //       // }

  //       print(response);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // DateTime _getPkgExpiry(int type) {
  //   DateTime expiryDate = DateTime.now();

  //   if (type == 1) {
  //     expiryDate = expiryDate.add(const Duration(days: 7));
  //   } else if (type == 2) {
  //     expiryDate = expiryDate.add(const Duration(days: 30));
  //   } else if (type == 3) {
  //     expiryDate = expiryDate.add(const Duration(days: 365));
  //   }

  //   return expiryDate;
  // }

  int _getPkgType(Package pkg) {
    switch (pkg.packageType) {
      case PackageType.weekly:
        return 1;
      case PackageType.monthly:
        return 2;
      default:
        return 3;
    }
  }
}
