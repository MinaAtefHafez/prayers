import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection time out with Api sever !');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send time out with Api Server !');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Received time out with Api Server !');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');
      case DioExceptionType.cancel:
        return ServerFailure('Request for Api is Canceled !');
      case DioExceptionType.badResponse:
        ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.connectionError:
        return ServerFailure('Please check your internet connection !');
      case DioExceptionType.unknown:
        return ServerFailure(
            'Oops , there was an error , please try again later');
    }
    return ServerFailure('Oops , there was an error , please try again later');
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error_message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found , please try again later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error , please try again later');
    } else {
      return ServerFailure(
          'Oops , there was an error , please try again later');
    }
  }
}

class LocalFailure extends Failure {
  LocalFailure(super.message);
}
