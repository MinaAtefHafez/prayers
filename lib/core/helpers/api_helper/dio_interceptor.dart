import 'package:dio/dio.dart';
import 'package:prayers/core/helpers/api_helper/end_points.dart';


class PrayerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiEndPoints.baseUrl;

    super.onRequest(options, handler);
  }
}
