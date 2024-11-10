import 'package:flutter/material.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';

extension DynamicHeight on num {
  double pxV(BuildContext context) {
    // Calculating that what was the percentage of the given value in figma
    const double figmaHeight = 932;
    double figmaRatio = (this * 100) / figmaHeight;

    // double currentScreenRatio = (MediaQuery.sizeOf(context).height -
    //         // MediaQuery.paddingOf(context).bottom -
    //         kToolbarHeight) *
    //     (figmaRatio / 100);

    double currentScreenRatio = figmaRatio.percentHeight(context);

    return currentScreenRatio;
    // return toDouble();
  }

  double pxH(BuildContext context) {
    // Calculating that what was the percentage of the given value in figma
    const double figmaWidth = 430;
    double figmaRatio = (this * 100) / figmaWidth;

    double currentScreenRatio = figmaRatio.percentWidth(context);

    return currentScreenRatio;
    // return toDouble();
  }

  double percentHeight(BuildContext context) {
    return (MediaQuery.sizeOf(GlobalContext.currentContext!).height) *
        (this / 100);
  }

  double percentWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * (this / 100);
  }
}
