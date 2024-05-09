class MethodsModel {
  MethodsModel({
    required this.code,
    required this.status,
    required this.data,
  });

  final int? code;
  final String? status;
  final Data? data;

  factory MethodsModel.fromJson(Map<String, dynamic> json) {
    return MethodsModel(
      code: json["code"],
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.mwl,
    required this.isna,
    required this.egypt,
    required this.makkah,
    required this.karachi,
    required this.tehran,
    required this.jafari,
    required this.gulf,
    required this.kuwait,
    required this.qatar,
    required this.singapore,
    required this.france,
    required this.turkey,
    required this.russia,
    required this.moonsighting,
    required this.dubai,
    required this.jakim,
    required this.tunisia,
    required this.algeria,
    required this.kemenag,
    required this.morocco,
    required this.portugal,
    required this.jordan,
    required this.custom,
  }) {
    methods = [
      mwl,
      isna,
      egypt,
      makkah,
      karachi,
      tehran,
      jafari,
      gulf,
      kuwait,
      qatar,
      singapore,
      france,
      turkey,
      russia,
      dubai,
      jakim,
      tunisia,
      algeria,
      kemenag,
      morocco,
      portugal,
      jordan,
    ];
  }

  final Algeria? mwl;
  final Algeria? isna;
  final Algeria? egypt;
  final Algeria? makkah;
  final Algeria? karachi;
  final Algeria? tehran;
  final Algeria? jafari;
  final Algeria? gulf;
  final Algeria? kuwait;
  final Algeria? qatar;
  final Algeria? singapore;
  final Algeria? france;
  final Algeria? turkey;
  final Algeria? russia;
  final Algeria? moonsighting;
  final Algeria? dubai;
  final Algeria? jakim;
  final Algeria? tunisia;
  final Algeria? algeria;
  final Algeria? kemenag;
  final Algeria? morocco;
  final Algeria? portugal;
  final Algeria? jordan;
  final Algeria? custom;

  Algeria get getEgypt => egypt!;

  late final List<dynamic> methods;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      mwl: json["MWL"] == null ? null : Algeria.fromJson(json["MWL"]),
      isna: json["ISNA"] == null ? null : Algeria.fromJson(json["ISNA"]),
      egypt: json["EGYPT"] == null ? null : Algeria.fromJson(json["EGYPT"]),
      makkah: json["MAKKAH"] == null ? null : Algeria.fromJson(json["MAKKAH"]),
      karachi:
          json["KARACHI"] == null ? null : Algeria.fromJson(json["KARACHI"]),
      tehran: json["TEHRAN"] == null ? null : Algeria.fromJson(json["TEHRAN"]),
      jafari: json["JAFARI"] == null ? null : Algeria.fromJson(json["JAFARI"]),
      gulf: json["GULF"] == null ? null : Algeria.fromJson(json["GULF"]),
      kuwait: json["KUWAIT"] == null ? null : Algeria.fromJson(json["KUWAIT"]),
      qatar: json["QATAR"] == null ? null : Algeria.fromJson(json["QATAR"]),
      singapore: json["SINGAPORE"] == null
          ? null
          : Algeria.fromJson(json["SINGAPORE"]),
      france: json["FRANCE"] == null ? null : Algeria.fromJson(json["FRANCE"]),
      turkey: json["TURKEY"] == null ? null : Algeria.fromJson(json["TURKEY"]),
      russia: json["RUSSIA"] == null ? null : Algeria.fromJson(json["RUSSIA"]),
      moonsighting: json["MOONSIGHTING"] == null
          ? null
          : Algeria.fromJson(json["MOONSIGHTING"]),
      dubai: json["DUBAI"] == null ? null : Algeria.fromJson(json["DUBAI"]),
      jakim: json["JAKIM"] == null ? null : Algeria.fromJson(json["JAKIM"]),
      tunisia:
          json["TUNISIA"] == null ? null : Algeria.fromJson(json["TUNISIA"]),
      algeria:
          json["ALGERIA"] == null ? null : Algeria.fromJson(json["ALGERIA"]),
      kemenag:
          json["KEMENAG"] == null ? null : Algeria.fromJson(json["KEMENAG"]),
      morocco:
          json["MOROCCO"] == null ? null : Algeria.fromJson(json["MOROCCO"]),
      portugal:
          json["PORTUGAL"] == null ? null : Algeria.fromJson(json["PORTUGAL"]),
      jordan: json["JORDAN"] == null ? null : Algeria.fromJson(json["JORDAN"]),
      custom: json["CUSTOM"] == null ? null : Algeria.fromJson(json["CUSTOM"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "MWL": mwl?.toJson(),
        "ISNA": isna?.toJson(),
        "EGYPT": egypt?.toJson(),
        "MAKKAH": makkah?.toJson(),
        "KARACHI": karachi?.toJson(),
        "TEHRAN": tehran?.toJson(),
        "JAFARI": jafari?.toJson(),
        "GULF": gulf?.toJson(),
        "KUWAIT": kuwait?.toJson(),
        "QATAR": qatar?.toJson(),
        "SINGAPORE": singapore?.toJson(),
        "FRANCE": france?.toJson(),
        "TURKEY": turkey?.toJson(),
        "RUSSIA": russia?.toJson(),
        "MOONSIGHTING": moonsighting?.toJson(),
        "DUBAI": dubai?.toJson(),
        "JAKIM": jakim?.toJson(),
        "TUNISIA": tunisia?.toJson(),
        "ALGERIA": algeria?.toJson(),
        "KEMENAG": kemenag?.toJson(),
        "MOROCCO": morocco?.toJson(),
        "PORTUGAL": portugal?.toJson(),
        "JORDAN": jordan?.toJson(),
        "CUSTOM": custom?.toJson(),
      };
}

class Algeria {
  Algeria({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  final int? id;
  final String? name;
  final AlgeriaParams? params;
  final Location? location;

  factory Algeria.fromJson(Map<String, dynamic> json) {
    return Algeria(
      id: json["id"],
      name: json["name"],
      params: json["params"] == null
          ? null
          : AlgeriaParams.fromJson(json["params"]),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "params": params?.toJson(),
        "location": location?.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class AlgeriaParams {
  AlgeriaParams({
    required this.fajr,
    required this.isha,
  });

  final String? fajr;
  final String? isha;

  factory AlgeriaParams.fromJson(Map<String, dynamic> json) {
    return AlgeriaParams(
      fajr: json["Fajr"].toString(),
      isha: json["Isha"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Isha": isha,
      };
}













    











