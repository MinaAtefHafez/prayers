
class LocalException implements Exception {
  final String errMesssage;

  LocalException(this.errMesssage);
}

class ServerException implements Exception {
  ServerException(this.errMessage);

  final String errMessage;
}

class LocationException implements Exception {
  LocationException(this.errMessage);

  final String errMessage;
}
