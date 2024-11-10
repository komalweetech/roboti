import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/service/remote/api_headers.dart';
import 'package:roboti_app/utils/extensions/string_extendsions.dart';
import 'package:roboti_app/utils/shared_pref_manager/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  final SharedPreferences _sharedPreferences;

  SharedPrefsManager(this._sharedPreferences);

  // Save data to shared preferences
  Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    }
    // Add more cases for other data types if needed
  }

  // Get data from shared preferences
  dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  String getUserId() {
    return _sharedPreferences.getString(LoginResponse.idKey) ?? "";
  }

  LoginResponse getUser() {
    String? token = _sharedPreferences.getString(LoginResponse.tokenKey);
    String? fName = _sharedPreferences.getString(LoginResponse.fNameKey);
    String? lName = _sharedPreferences.getString(LoginResponse.lNameKey);
    String? name = _sharedPreferences.getString(LoginResponse.nameKey);
    String? email = _sharedPreferences.getString(LoginResponse.emailKey);
    String? id = _sharedPreferences.getString(LoginResponse.idKey);
    String? country =
        _sharedPreferences.getString(LoginResponse.countryKey) ?? "";
    String imageUrl =
        _sharedPreferences.getString(LoginResponse.imageKey) ?? "";
    String? planExpiry =
        _sharedPreferences.getString(LoginResponse.planExpiryDate);
    String planType =
        _sharedPreferences.getString(LoginResponse.planTypeKey) ?? "none";
    bool isPlanActive =
        _sharedPreferences.getBool(LoginResponse.isPlanActiveKey) ?? false;
    int trialCounter =
        _sharedPreferences.getInt(LoginResponse.trialCounterKey) ?? 0;

    LoginResponse user = LoginResponse(
      email: email,
      isActive: null,
      isVerified: null,
      accessToken: token,
      message: "",
      name: name,
      id: id,
      imageUrl: imageUrl,
      lName: lName,
      fName: fName,
      country: country,
      isPlanActive: isPlanActive,
      planType: getPlanType(planType),
      trialCounter: trialCounter,
      planExpireAt: planExpiry.toString() == "null"
          ? null
          : DateTime.parse(planExpiry.toString()),
    );

    return user;
  }

  Future<void> saveUser(LoginResponse user) async {
    await _sharedPreferences.setString(
        LoginResponse.tokenKey, user.accessToken!);
    String name = user.email!.split("@").first;
    if (user.fName != null &&
        user.fName!.isNotEmpty &&
        user.fName!.toLowerCase() != "null") {
      name = user.fName!;
    }
    name = name.capitalizeFirst();

    user.name = name;
    await _sharedPreferences.setString(LoginResponse.nameKey, name);
    await _sharedPreferences.setString(
        LoginResponse.emailKey, user.email ?? "");
    await _sharedPreferences.setString(LoginResponse.idKey, user.id ?? "");
    await _sharedPreferences.setString(
        LoginResponse.tokenKey, user.accessToken ?? "");
    await _sharedPreferences.setString(LoginResponse.imageKey, user.imageUrl);
    await _sharedPreferences.setString(
        LoginResponse.fNameKey, user.fName ?? "");
    await _sharedPreferences.setString(
        LoginResponse.lNameKey, user.lName ?? "");
    await _sharedPreferences.setString(
        LoginResponse.countryKey, user.country ?? "");
    await _sharedPreferences.setInt(LoginResponse.trialMember, 0);
    ApiHeaders.userAccessToken = user.accessToken!;

    await _sharedPreferences.setString(
        LoginResponse.planExpiryDate, user.planExpireAt.toString());
    await _sharedPreferences.setString(
        LoginResponse.planTypeKey, user.getPlanTypeString());
    await _sharedPreferences.setBool(
        LoginResponse.isPlanActiveKey, user.isPlanActive);

    await _sharedPreferences.setInt(
        LoginResponse.trialCounterKey, user.trialCounter);

    registerUserInDependency(user);
  }

  Future<void> removeUserToken() async {
    await _sharedPreferences.remove(LoginResponse.trialMember);
    await _sharedPreferences.remove(LoginResponse.tokenKey);
    await _sharedPreferences.remove(PrefKeys.fcmKey);
  }

  Future<void> removeTrial() async {
    await _sharedPreferences.remove(PrefKeys.trialLimit);
  }

  void registerUserInDependency(LoginResponse user) {
    // try {
    //   GetIt.instance.registerSingleton<LoginResponse>(user);
    // } catch (e) {
    //   GetIt.instance.unregister<LoginResponse>();
    //   GetIt.instance.registerSingleton<LoginResponse>(user);
    // }
    // getIt<LoginResponse>().copy(user);
    homeBloc.loginResponse.copy(user);
  }

  Future<void> setLocale(String languageCode) async {
    await _sharedPreferences.setString(PrefKeys.langCodeKey, languageCode);
  }

  Future<AppLocale> getLocale() async {
    String storedLangCode =
        _sharedPreferences.getString(PrefKeys.langCodeKey) ?? AppLocale.en.name;

    if (storedLangCode == AppLocale.ar.name) {
      return AppLocale.ar;
    } else {
      return AppLocale.en;
    }
  }
}
