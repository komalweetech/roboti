import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<Locale> saveUserLocaleSelection(AppLocale locale) async {
  await getIt<SharedPrefsManager>().setLocale(locale.name);
  return _locale(locale);
}

Future<Locale> getLocale() async {
  homeBloc.selectedLocale = await getIt<SharedPrefsManager>().getLocale();
  return _locale(homeBloc.selectedLocale);
}

Locale _locale(AppLocale locale) {
  switch (locale) {
    case AppLocale.en:
      return Locale(AppLocale.en.name, '');
    case AppLocale.ar:
      return Locale(AppLocale.ar.name, '');
    default:
      return Locale(AppLocale.en.name, '');
  }
}

AppLocalizations lc(BuildContext context) => AppLocalizations.of(context)!;
AppLocalizations get lcGlobal =>
    AppLocalizations.of(GlobalContext.currentContext!)!;
