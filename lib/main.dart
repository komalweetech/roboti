import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/firebase_options.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
}

Future<void> setupFlutterNotifications() async {
  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  final lo = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(lo);

  await initializeFirebaseApp();
  // final token = await FirebaseMessaging.instance.getToken();
  // print('$token==========token');
  await setupDI();
  await dotenv.load(fileName: ".env");
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

Future<void> initializeFirebaseApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
