import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prayers/core/exceptions/failures.dart';
import 'package:prayers/core/helpers/api_helper/end_points.dart';
import 'package:prayers/core/helpers/hijri_helper/hijri_helper.dart';
import 'package:prayers/core/helpers/intl_helper/intl_helper.dart';
import 'package:prayers/core/helpers/shared_preference/local_storage_keys.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';
import 'package:prayers/features/gregorian/data/models/gregorian_year_model.dart';
import '../../../../core/helpers/api_helper/api_consumer.dart';

abstract class GregorianRepo {
  Future<Either<Failure, (GregorianModel, Map<String, dynamic>)>>
      getGregorianYear(Map<String, dynamic> param);

  Future<void> saveGregorianYearLocal(Map<String, dynamic> data);
  Future<GregorianModel> getGregorianForYearLocal();
  Future<void> saveYearNowLocal();
  Future<String?> getYearNowLocal();
  Future<Either<Failure, (GregorianModel, Map<String, dynamic>)>>
      getHijriCalendarYear(Map<String, dynamic> param);
  Future<void> saveHijriCalendarYearLocal(Map<String, dynamic> data);
  Future<GregorianModel> getHijriCalendarYearLocal();
  Future<void> saveHijriYearNowLocal();
  Future<String?> getHijriYearNowLocal();
}

class GregorianRepoImpl implements GregorianRepo {
  final ApiConsumer _apiConsumer;

  GregorianRepoImpl(this._apiConsumer);

  @override
  Future<Either<Failure, (GregorianModel, Map<String, dynamic>)>>
      getGregorianYear(Map<String, dynamic> param) async {
    try {
      final yearNow = IntlHelper.yearNow;
      final data = await _apiConsumer.get(
          url: '${ApiEndPoints.calendar}/$yearNow', queryParam: param);
      return right((GregorianModel.fromJson(data), data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }

  @override
  Future<void> saveGregorianYearLocal(Map<String, dynamic> data) async {
    SharedPref.setValue(LocalStorageKeys.gregorinYear, value: jsonEncode(data));
  }

  @override
  Future<GregorianModel> getGregorianForYearLocal() async {
    final data = SharedPref.getValue(LocalStorageKeys.gregorinYear) as String;
    return GregorianModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> saveYearNowLocal() async {
    final yearNow = IntlHelper.yearNow;
    SharedPref.setValue(LocalStorageKeys.yearNow, value: yearNow);
  }

  @override
  Future<String?> getYearNowLocal() async {
    final data = SharedPref.getValue(LocalStorageKeys.yearNow) as String?;
    return data;
  }

  @override
  Future<Either<Failure, (GregorianModel, Map<String, dynamic>)>>
      getHijriCalendarYear(Map<String, dynamic> param) async {
    try {
      final hijriYearNow = HijriHelper.hijriYearNow;
      final data = await _apiConsumer.get(
          url: '${ApiEndPoints.hijriCalendar}/$hijriYearNow',
          queryParam: param);
      return right((GregorianModel.fromJson(data), data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }

  @override
  Future<GregorianModel> getHijriCalendarYearLocal() async {
    final data = SharedPref.getValue(LocalStorageKeys.hijriCalendar) as String;
    return GregorianModel.fromJson(jsonDecode(data));
  }

  @override
  Future<String?> getHijriYearNowLocal() async {
    final data = SharedPref.getValue(LocalStorageKeys.hijriYear) as String?;
    return data;
  }

  @override
  Future<void> saveHijriCalendarYearLocal(Map<String, dynamic> data) async {
    SharedPref.setValue(LocalStorageKeys.hijriCalendar,
        value: jsonEncode(data));
  }

  @override
  Future<void> saveHijriYearNowLocal() async {
    SharedPref.setValue(LocalStorageKeys.hijriYear,
        value: HijriHelper.hijriYearNow);
  }
}
