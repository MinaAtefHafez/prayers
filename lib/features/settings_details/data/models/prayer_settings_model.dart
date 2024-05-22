// ignore_for_file: public_member_api_docs, sort_constructors_first
class PrayerSettingsModel {
  String? prayerName;
  bool? isShow;
  int? minutes;
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
