import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/profile/view_model/repo/profile_request_parser.dart';
import 'package:roboti_app/presentation/subscription/models/trial_model.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';

class ProfileRepo {
  final NetworkApiService _apiService = NetworkApiService();
  final ProfileRequestParser _requestParser = ProfileRequestParser();
  Future<LoginResponse> updateProfile({
    required String? image,
    required String name,
    required String country,
  }) async {
    String request = _requestParser.updateProfileRequest(
      imageUrl: image,
      name: name,
      country: country,
    );
    Map<String, dynamic> response =
        await _apiService.getPostApiResponse(ApiUrls.updateProfile, request);

    // print(response);
    LoginResponse user = LoginResponse.initial();

    if (response['data'] != null && response['data']['response'] != null) {
      user = LoginResponse.fromUpdateProfile(response);
    } else {
      user.message = response['message'];
    }
    // UserModel user = UserModel.fromChangeProfile(response);

    return user;
  }

  Future<LoginResponse> getUserProfile() async {
    Map<String, dynamic> response =
        await _apiService.getGetApiResponse(ApiUrls.getProfile);

    // print(response);
    LoginResponse user = LoginResponse.initial();

    if (response['data'] != null && response['data']['response'] != null) {
      user = LoginResponse.fromUpdateProfile(response);
    } else {
      user.message = response['message'];
    }
    // UserModel user = UserModel.fromChangeProfile(response);

    return user;
  }

  Future<TrialModel?> getUserTrialBalance() async {
    TrialModel? result;
    Map<String, dynamic> response =
        await _apiService.getGetApiResponse(ApiUrls.getProfile);

    // print(response);
    if (response['data'] != null && response['data']['response'] != null) {
      // var info = await PurchaseService().getSubscriptionInfo();
      // homeBloc.loginResponse.updatePkgInfoFromRevenueCat(info: info);
      // subscriptionBloc.add(UpdateSubscriptionStatusEvent(forceUpdate: true));
      return TrialModel(
        isPlanActive: response['data']['response']['isPlanActive'] ?? false,
        trialLimit: response['data']['response']['trial_counter'] ?? 0,
        isFreeUser: response['data']['response']['isFree'] ?? false,
      );
    }

    return result;
  }

  Future<DateTime?> getUserPlanExpiryFromBackend() async {
    Map<String, dynamic> response =
        await _apiService.getGetApiResponse(ApiUrls.getProfile);

    // print(response);
    if (response['data'] != null && response['data']['response'] != null) {
      return DateTime.parse(response['data']['response']['planExpireAt']);
    }

    return null;
  }

  Future<int> updateTrialCounter() async {
    Map<String, dynamic> response =
        await _apiService.getPostApiResponse(ApiUrls.updateCounter, "");

    // print(response);
    if (response['data'] != null && response['data']['response'] != null) {
      return response['data']['response']['trial_counter'];
    }

    return 0;
  }

  Future<int> resetTrialCounter() async {
    Map<String, dynamic> response =
        await _apiService.getPostApiResponse(ApiUrls.resetCounter, "");

    // print(response);
    if (response['data'] != null && response['data']['response'] != null) {
      return response['data']['response']['trial_counter'];
    }

    return 0;
  }
}
