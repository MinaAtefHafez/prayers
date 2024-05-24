import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayers/features/settings_details/data/models/prayer_settings_model/prayer_settings_model.dart';

abstract class HiveHelper {
  static late final Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PrayerSettingsModelAdapter());
    box = await Hive.openBox(HiveConstants.box);
  }

  static bool isContainesKey(String key) {
    return box.containsKey(key);
  }

  static Future<void> putData<T>(
      {required String key, required T value}) async {
    await box.put(key, value);
  }

  static Future<dynamic> getData({required String key}) async {
    return box.get(key);
  }
}

abstract class HiveConstants {
  static const String box = 'data';
  static const String settings = 'settings';
}
