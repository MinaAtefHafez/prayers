// ignore_for_file: public_member_api_docs, sort_constructors_first
class PrayerModel {
  final String? prayerName;
  final String? prayerDate;
  final String? differnece;

  PrayerModel({this.prayerName, this.prayerDate, this.differnece});

  PrayerModel copyWith({
    String? prayerName,
    String? prayerDate,
    String? differnece,
  }) {
    return PrayerModel(
      prayerName: prayerName ?? this.prayerName,
      prayerDate: prayerDate ?? this.prayerDate,
      differnece: differnece ?? this.differnece,
    );
  }
}
