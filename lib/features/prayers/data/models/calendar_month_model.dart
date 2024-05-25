import 'package:prayers/features/prayers/data/models/prayer_model.dart';

class CalendarMonthModel {
  CalendarMonthModel({
    required this.code,
    required this.status,
    required this.data,
  });

  final int? code;
  final String? status;
  final List<Datum> data;

  factory CalendarMonthModel.fromJson(Map<String, dynamic> json) {
    return CalendarMonthModel(
      code: json["code"],
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    this.timings,
    this.date,
    this.meta,
  });

  final Timings? timings;
  final Date? date;
  final Meta? meta;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      timings:
          json["timings"] == null ? null : Timings.fromJson(json["timings"]),
      date: json["date"] == null ? null : Date.fromJson(json["date"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class Date {
  Date({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });

  final String? readable;
  final String? timestamp;
  final Gregorian? gregorian;
  final Hijri? hijri;

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      readable: json["readable"],
      timestamp: json["timestamp"],
      gregorian: json["gregorian"] == null
          ? null
          : Gregorian.fromJson(json["gregorian"]),
      hijri: json["hijri"] == null ? null : Hijri.fromJson(json["hijri"]),
    );
  }
}

class Gregorian {
  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  final String? date;
  final String? format;
  final String? day;
  final GregorianWeekday? weekday;
  final GregorianMonth? month;
  final String? year;
  final Designation? designation;

  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(
      date: json["date"],
      format: json["format"],
      day: json["day"],
      weekday: json["weekday"] == null
          ? null
          : GregorianWeekday.fromJson(json["weekday"]),
      month:
          json["month"] == null ? null : GregorianMonth.fromJson(json["month"]),
      year: json["year"],
      designation: json["designation"] == null
          ? null
          : Designation.fromJson(json["designation"]),
    );
  }
}

class Designation {
  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  final String? abbreviated;
  final String? expanded;

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json["abbreviated"],
      expanded: json["expanded"],
    );
  }
}

class GregorianMonth {
  GregorianMonth({
    required this.number,
    required this.en,
  });

  final int? number;
  final String? en;

  factory GregorianMonth.fromJson(Map<String, dynamic> json) {
    return GregorianMonth(
      number: json["number"],
      en: json["en"],
    );
  }
}

class GregorianWeekday {
  GregorianWeekday({
    required this.en,
  });

  final String? en;

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) {
    return GregorianWeekday(
      en: json["en"],
    );
  }
}

class Hijri {
  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  final String? date;
  final String? format;
  final String? day;
  final HijriWeekday? weekday;
  final HijriMonth? month;
  final String? year;
  final Designation? designation;
  final List<dynamic> holidays;

  factory Hijri.fromJson(Map<String, dynamic> json) {
    return Hijri(
      date: json["date"],
      format: json["format"],
      day: json["day"],
      weekday: json["weekday"] == null
          ? null
          : HijriWeekday.fromJson(json["weekday"]),
      month: json["month"] == null ? null : HijriMonth.fromJson(json["month"]),
      year: json["year"],
      designation: json["designation"] == null
          ? null
          : Designation.fromJson(json["designation"]),
      holidays: json["holidays"] == null
          ? []
          : List<dynamic>.from(json["holidays"]!.map((x) => x)),
    );
  }
}

class HijriMonth {
  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
  });

  final int? number;
  final String? en;
  final String? ar;

  factory HijriMonth.fromJson(Map<String, dynamic> json) {
    return HijriMonth(
      number: json["number"],
      en: json["en"],
      ar: json["ar"],
    );
  }
}

class HijriWeekday {
  HijriWeekday({
    required this.en,
    required this.ar,
  });

  final String? en;
  final String? ar;

  factory HijriWeekday.fromJson(Map<String, dynamic> json) {
    return HijriWeekday(
      en: json["en"],
      ar: json["ar"],
    );
  }
}

class Meta {
  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  final double? latitude;
  final double? longitude;
  final String? timezone;
  final Method? method;
  final String? latitudeAdjustmentMethod;
  final String? midnightMode;
  final String? school;
  final Map<String, int> offset;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      latitude: json["latitude"],
      longitude: json["longitude"],
      timezone: json["timezone"],
      method: json["method"] == null ? null : Method.fromJson(json["method"]),
      latitudeAdjustmentMethod: json["latitudeAdjustmentMethod"],
      midnightMode: json["midnightMode"],
      school: json["school"],
      offset:
          Map.from(json["offset"]).map((k, v) => MapEntry<String, int>(k, v)),
    );
  }
}

class Method {
  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  final int? id;
  final String? name;
  final Params? params;
  final Location? location;

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json["id"],
      name: json["name"],
      params: json["params"] == null ? null : Params.fromJson(json["params"]),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
    );
  }
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}

class Params {
  Params({
    required this.fajr,
    required this.isha,
  });

  final double? fajr;
  final double? isha;

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      fajr: json["Fajr"],
      isha: json["Isha"],
    );
  }
}

class Timings {
  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  }) {
    prayers = [
      PrayerModel(prayerName: 'Fajr', prayerDate: fajr!),
      PrayerModel(prayerName: 'Sunrise', prayerDate: sunrise!),
      PrayerModel(prayerName: 'Dhuhr', prayerDate: dhuhr!),
      PrayerModel(prayerName: 'Asr', prayerDate: asr!),
      PrayerModel(prayerName: 'Maghrib', prayerDate: maghrib!),
      PrayerModel(prayerName: 'Isha', prayerDate: isha!),
      PrayerModel(prayerName: 'Imsak', prayerDate: imsak!),
      PrayerModel(prayerName: 'Midnight', prayerDate: midnight!),
    ];
    prayers.sort((a, b) => a.prayerDate!.compareTo(b.prayerDate!));
  }

  final String? fajr;
  final String? sunrise;
  final String? dhuhr;
  final String? asr;
  final String? sunset;
  final String? maghrib;
  final String? isha;
  final String? imsak;
  final String? midnight;
  final String? firstthird;
  final String? lastthird;

  late List<PrayerModel> prayers;
  late List<PrayerModel> prayersThatRemovedFromPrayersList;

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json["Fajr"],
      sunrise: json["Sunrise"],
      dhuhr: json["Dhuhr"],
      asr: json["Asr"],
      sunset: json["Sunset"],
      maghrib: json["Maghrib"],
      isha: json["Isha"],
      imsak: json["Imsak"],
      midnight: json["Midnight"],
      firstthird: json["Firstthird"],
      lastthird: json["Lastthird"],
    );
  }
}
