import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotifHelper {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestAlertPermission: true,
    );

    await _flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin));
  }

  static Future<void> showSoundNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('PrayersId', 'Prayers',
            importance: Importance.max,
            priority: Priority.high,
            category: AndroidNotificationCategory.alarm,
            enableVibration: true,
            fullScreenIntent: true,
            playSound: true,
            channelShowBadge: true,
            autoCancel: false,
            visibility: NotificationVisibility.public,
            sound: RawResourceAndroidNotificationSound('takber'));

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      categoryIdentifier: 'Alarm',
      sound: 'takber',
      presentSound: true,
      presentBadge: true,
      presentList: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: darwinDetails);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Prayers',
      'sdfsdfsdfsdfsd',
      notificationDetails,
    );
  }
}
