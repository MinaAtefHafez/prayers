import 'package:location/location.dart';
import 'package:prayers/core/exceptions/exceptions.dart';

abstract class LocationHelper {
  static final Location _location = Location();

  static Future<bool> locationServicePermission() async {
    bool isServiceEnabled = await _location.serviceEnabled();
    if (isServiceEnabled) return true;
    isServiceEnabled = await _location.requestService();
    if (isServiceEnabled) {
      return true;
    } else {
      throw LocationException('NeedLocationPermission');
    }
  }

  static Future<bool> locationPermission() async {
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.granted) return true;
    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        throw LocationException('NeedLocationPermission');
      }
    } else {
      throw LocationException('NeedLocationPermission');
    }
  }

  static Future<LocationData> getLocation() async {
    await locationServicePermission();
    await locationPermission();
    return _location.getLocation();
  }

  static void onLocationChange(Function(LocationData)? onData) async {
    await locationServicePermission();
    await locationPermission();
    _location.onLocationChanged.listen(onData);
  }
}
