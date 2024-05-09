import 'package:dio/dio.dart';
import 'package:prayers/core/helpers/api_helper/dio_interceptor.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio _dio;

  DioConsumer(this._dio) {
    _dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..sendTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5);
    _dio.interceptors.add(PrayerInterceptor());
  }

  @override
  Future<dynamic> get(
      {required String url, Map<String, dynamic>? queryParam}) async {
    final response = await _dio.get(url, queryParameters: queryParam);
    return response.data;
  }

  @override
  Future<dynamic> post(
      {required String url, dynamic body, dynamic query}) async {
    final response = await _dio.post(url, data: body, queryParameters: query);
    return response.data;
  }
}
