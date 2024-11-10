import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roboti_app/data/api/api_service.dart';
import 'package:roboti_app/data/repositories/api_repository.dart';
import 'package:roboti_app/utils/app_routes/app_routes.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

GetIt getIt = GetIt.instance;

setupDI() async {
  // AppRoutes initialization
  getIt.registerLazySingleton<AppRoutes>(() => AppRoutes());

  // Package Infromation Plus
  final packageInfo = await PackageInfo.fromPlatform();
  getIt.registerLazySingleton(() => packageInfo);

  // Shared Preference Instance
  final pref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => pref);

  // Register Shared Pref Manager that depends on SharedPreferences
  getIt.registerLazySingleton(() => SharedPrefsManager(getIt.get()));

  // ApiServices
  getIt.registerLazySingleton(() => ApiService(getIt.get()));

  // Api Repository
  getIt.registerLazySingleton(() => ApiRepository(getIt.get()));

  getIt.registerLazySingleton<TextStyleCustom>(() => TextStyleCustom());

  // Api Repository
  // getIt.registerLazySingleton(() => HomeViewModel(getIt.get()));

  // Font Family Name
  String aeonik = 'aeonik';
  getIt.registerSingleton<String>(aeonik, instanceName: 'f1');
}
