

import 'package:hive/hive.dart';
part 'prayer_settings_model.g.dart';
@HiveType(typeId: 0)
class PrayerSettingsModel {
  @HiveField(0)
  String? prayerName;
  @HiveField(1)
  bool? isShow;
  @HiveField(2)
  int? minutes;
  @HiveField(3)
  bool? isNotify;

  PrayerSettingsModel(
      {this.isShow, this.minutes, this.isNotify, this.prayerName});

  PrayerSettingsModel copyWith({
    String? prayerName,
    bool? isShow,
    int? minutes,
    bool? isNotify,
  }) {
    return PrayerSettingsModel(
      prayerName: prayerName ?? this.prayerName,
      isShow: isShow ?? this.isShow,
      minutes: minutes ?? this.minutes,
      isNotify: isNotify ?? this.isNotify,
    );
  }
}
