import 'package:location/location.dart';

class LocationModel {
  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  final double? latitude;
  final double? longitude;
  final String? locationName;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json["latitude"],
      longitude: json["longitude"],
      locationName: json["locationName"],
    );
  }

  factory LocationModel.fromLocationData(LocationData locationData) {
    return LocationModel(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
        locationName: '');
  }

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? locationName,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "locationName": locationName,
      };
}
