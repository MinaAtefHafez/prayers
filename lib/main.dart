import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayers/app.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/helpers/hive_helper/hive_helper.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';
import 'package:prayers/core/theme/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'Prayer',
        channelName: 'Prayers Channel',
        channelDescription: 'PrayersApp channel',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white),
  ]);

  await AwesomeNotifications().isNotificationAllowed().then((value) async {
    if (!value) {
      await openAppSettings();
    }
  });

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'Prayer',
          actionType: ActionType.Default,
          autoDismissible: false,
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 5),
          title: 'Hello',
          body: 'Hello, how are you?',
          locked: false));

  await EasyLocalization.ensureInitialized();
  await Future.wait([setUpLocator(), SharedPref.init(), HiveHelper.init()]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: const Locale('ar'),
      path: 'assets/localization',
      child: const MyApp()));
}
