import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/auth_bloc.dart';
import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/app_routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool isEng = true;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      isEng = _locale!.languageCode == AppLocale.en.name;
    });
  }

  @override
  void initState() {
    super.initState();
    homeBloc.add(RefreshAppLanguageEvent());
    getLocale().then((locale) => setLocale(locale));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale) => setLocale(locale));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => authBloc),
        BlocProvider(create: (BuildContext context) => chatBloc),
        BlocProvider(create: (BuildContext context) => homeBloc),
        BlocProvider(create: (BuildContext context) => profileBloc),
        BlocProvider(create: (BuildContext context) => newsBloc),
        BlocProvider(create: (BuildContext context) => historyBloc),
        BlocProvider(create: (BuildContext context) => subscriptionBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalContext.navigatorKey,
        theme: ThemeData(
          fontFamily: getIt<String>(instanceName: 'f1'),
          primarySwatch: MaterialColor(100, MyColors.primarySwatch),
          primaryColor: MyColors.black0D0D0D,
          appBarTheme: const AppBarTheme(
            backgroundColor: MyColors.primaryDarkBlue060A19,
          ),
          scaffoldBackgroundColor: MyColors.primaryDarkBlue060A19,
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.black0D0D0D),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: MyColors.primaryDarkBlue060A19,
          ),
          dialogBackgroundColor: MyColors.primaryDarkBlue060A19,
          checkboxTheme: CheckboxThemeData(
            splashRadius: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          CountryLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        routes: getIt<AppRoutes>().routes,
      ),
    );
  }
}
