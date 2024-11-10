import 'package:flutter/material.dart';
import 'package:roboti_app/service/di.dart';
import 'my_colors.dart';
import 'text_styling.dart';

final myLightThemeData = ThemeData(
  canvasColor: Colors.transparent,
  fontFamily: getIt<String>(instanceName: "f1"),
  // primaryColor: MyColors.white,
  // scaffoldBackgroundColor: MyColors.bgPageColor,
  textTheme: TextStyleCustom(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: myTextStyle.font_13w700,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: MyColors.black0D0D0D,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 16,
    foregroundColor: MyColors.white,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: myTextStyle.font_13w700,
      shadowColor: MyColors.transparent,
      backgroundColor: MyColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    ),
  ),
  // colorScheme: ColorScheme.fromSwatch().copyWith(
  //   secondary: MyColors.themeGreen,
  //
  // ),
);
