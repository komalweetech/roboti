import 'package:flutter/material.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/utils/app_routes/app_routes.dart';
import 'package:roboti_app/utils/app_routes/page_trasnsitions.dart';

const int duration = 800;

extension RouteContext on BuildContext {
  //for routes
  pop<T>({T? result}) => Navigator.pop(this, result);

  pushNamed(String routeName, {Object? args}) =>
      Navigator.pushNamed(this, routeName, arguments: args);

  pushReplacementNamed(String routeName, {Object? args}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: args);

  pushNamedAndRemoveUntil(String routeName, {Object? args}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (Route route) => false,
        arguments: args,
      );

  push(String routeName, {Object? args}) => Navigator.push(
        this,
        MaterialPageRoute(
            builder: (context) => getIt<AppRoutes>().returnScreen(routeName)),
      );

  pushRoute(Widget screen) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => screen));

  pushLTR(String routeName, {Object? args, int duration = duration}) =>
      Navigator.push(
        this,
        LTRPageRoute(
          getIt<AppRoutes>().returnScreen(routeName),
          duration: duration,
        ),
      );

  pushRTL(String routeName, {Object? args, int duration = duration}) =>
      Navigator.push(
        this,
        RTLPageRoute(
          getIt<AppRoutes>().returnScreen(routeName),
          duration: duration,
        ),
      );

  pushTTB(String routeName, {Object? args, int duration = duration}) =>
      Navigator.push(
        this,
        TTBPageRoute(
          getIt<AppRoutes>().returnScreen(routeName),
          duration: duration,
        ),
      );
  pushBTT(Widget screen, {Object? args, int duration = duration}) =>
      Navigator.push(
        this,
        BTTPageRoute(
          screen,
          // getIt<AppRoutes>().returnScreen(routeName),
          duration: duration,
        ),
      );
}
