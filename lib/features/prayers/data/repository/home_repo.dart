import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prayers/core/exceptions/failures.dart';
import 'package:prayers/core/helpers/api_helper/api_consumer.dart';
import 'package:prayers/core/helpers/api_helper/end_points.dart';
import 'package:prayers/core/helpers/intl_helper/intl_helper.dart';
import 'package:prayers/core/helpers/shared_preference/local_storage_keys.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';
import 'package:prayers/features/prayers/data/models/calendar_month_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, (CalendarMonthModel, Map<String, dynamic>)>>
      getCalendarMonth(Map<String, dynamic> param);
  Future<void> saveCalendarMonthLocal(Map<String, dynamic> calendar);
  Future<CalendarMonthModel> getCalendarYearLocal();
  Future<void> saveYearNowLocal();
  Future<String?> getYearNowLocal();
}

class HomeRepoImpl implements HomeRepo {
  final ApiConsumer _dioConsumer;

  HomeRepoImpl(this._dioConsumer);

  @override
  Future<Either<Failure, (CalendarMonthModel, Map<String, dynamic>)>>
      getCalendarMonth(Map<String, dynamic> param) async {
    try {
      final result = await _dioConsumer.get(
          url:
              '${ApiEndPoints.calendar}/${IntlHelper.yearNow}/${IntlHelper.monthNow}',
          queryParam: param);
      return right((CalendarMonthModel.fromJson(result), result));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }

  @override
  Future<void> saveCalendarMonthLocal(Map<String, dynamic> calendar) async {
    final String calendarAsString = jsonEncode(calendar);
    SharedPref.setValue(LocalStorageKeys.calendarMonth,
        value: calendarAsString);
  }

  @override
  Future<CalendarMonthModel> getCalendarYearLocal() async {
    final result =
        SharedPref.getValue(LocalStorageKeys.calendarMonth) as String;
    return Future.value(CalendarMonthModel.fromJson(jsonDecode(result)));
  }

  @override
  Future<void> saveYearNowLocal() async {
    SharedPref.setValue(LocalStorageKeys.prayerYearNow,
        value: IntlHelper.yearNow);
  }

  @override
  Future<String?> getYearNowLocal() async {
    final data = SharedPref.getValue(LocalStorageKeys.prayerYearNow) as String?;
    return data;
  }
}
