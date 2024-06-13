import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prayers/app.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/helpers/hive_helper/hive_helper.dart';
import 'package:prayers/core/helpers/local_notif_helper/local_notif_helper.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';

import 'core/helpers/background_service/background_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    setUpLocator(),
    SharedPref.init(),
    HiveHelper.init(),
    LocalNotifHelper.init()
  ]);

  await BackgroundService.initializeService();

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
