import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/helpers/hive_helper/hive_helper.dart';
import 'package:prayers/core/helpers/intl_helper/intl_helper.dart';
import 'package:prayers/core/helpers/local_notif_helper/local_notif_helper.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';
import 'package:prayers/features/prayers/presentation/prayers_cubit/prayers_cubit.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

abstract class BackgroundService {
  static final _service = FlutterBackgroundService();

  static Future<void> initializeService() async {
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true ,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  static onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
      service.on('stopService').listen((event) {
        service.stopSelf();
      });
    }
    await initializeDateFormatting();
    await setUpLocator();
    await HiveHelper.init();
    await SharedPref.init();
    Timer.periodic(const Duration(seconds: 37), (_) async {
      await backgroundService();
    });
  }

  static Future<bool> onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return Future.value(true);
  }

  static Future<void> backgroundService() async {
    final prayerCubit = di<PrayersCubit>();
    final settingsCubit = di<SettingsCubit>();
    await settingsCubit.savePrayersSettingsLocal();
    await settingsCubit.getPrayersSettingsLocal();
    await prayerCubit.getYearNowLocal();
    await prayerCubit.callCalendarApiOrLocal();
    await prayerCubit.getPrayers();
    final settings = settingsCubit.getSettingsMap;
    final prayersToday = prayerCubit.getPrayerToday;
    for (var prayer in prayersToday!.timings!.prayers) {
      final timeNow = IntlHelper.dateTime();
      final prayerTime = IntlHelper.dateTime(prayer.prayerDate);
      final difference = prayerTime.difference(timeNow).inMinutes;
      if (!settings[prayer.prayerName]!.isNotify) continue;
      if (difference != 3) continue;
      await LocalNotifHelper.init();
      await LocalNotifHelper.showSoundNotification(
          title: prayer.prayerName!,
          subTitle: prayer.prayerDate!.split(' ').first);
    }
  }
}
