import 'package:flutter/material.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

import 'my_colors.dart';

final myTextStyle = getIt.get<TextStyleCustom>();

class TextStyleCustom extends TextTheme {
  final TextStyle _textStyle = TextStyle(
    fontFamily: getIt<String>(instanceName: 'f1'),
    color: MyColors.whiteFFFFFF,
  );

  @override
  TextStyle get titleLarge => _textStyle;

  ///48 font family (Main Heading)
  TextStyle get font_48wMedium => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 48.pxV(GlobalContext.currentContext!),
      );

  ///39 font family (Main Heading)
  TextStyle get font_39wMedium => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 39.pxV(GlobalContext.currentContext!),
      );

  ///25 font family (Main Heading)
  TextStyle get font_25wRegular => titleLarge.copyWith(
        fontSize: 25.pxV(GlobalContext.currentContext!),
      );

  ///20 font family (Main Heading)
  TextStyle get font_20wMedium => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20.pxV(GlobalContext.currentContext!),
      );

  ///32 font family (Main Heading)
  TextStyle get font_32w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32.pxV(GlobalContext.currentContext!),
      );

  ///13 font family (Button Text)
  TextStyle get font_13w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 13.pxV(GlobalContext.currentContext!),
      );
  TextStyle get font_13w700Black => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 13.pxV(GlobalContext.currentContext!),
        color: MyColors.black0D0D0D,
      );

  TextStyle get font_12w400 => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 12.pxV(GlobalContext.currentContext!),
      );

  TextStyle get font_13w300 => titleLarge.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 13.pxV(GlobalContext.currentContext!),
      );
  TextStyle get font_13w300Black => titleLarge.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 13.pxV(GlobalContext.currentContext!),
        color: MyColors.black0D0D0D,
      );

  TextStyle get font_12w500Black => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11.pxV(GlobalContext.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_12w500 => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11.pxV(GlobalContext.currentContext!),
      );
  TextStyle get font_12w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 11.pxV(GlobalContext.currentContext!),
      );

  ///16 font family (Button Text)
  TextStyle get font_16wRegular => titleLarge.copyWith(
        fontSize: 16.pxV(GlobalContext.currentContext!),
      );

  ///14 font family (Button Text)
  TextStyle get font_14w400 => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.pxV(GlobalContext.currentContext!),
      );
  TextStyle get font_14w400Black => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.pxV(GlobalContext.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_14w500 => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.pxV(GlobalContext.currentContext!),
      );
  TextStyle get font_14w500Black => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.pxV(GlobalContext.currentContext!),
        color: MyColors.black0D0D0D,
      );

  TextStyle get font_31BoldGreen => titleLarge.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 31.pxV(GlobalContext.currentContext!),
        color: MyColors.green67FF66,
      );
  TextStyle get font_25BoldGreen => titleLarge.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 25.pxV(GlobalContext.currentContext!),
        color: MyColors.green67FF66,
      );
}
