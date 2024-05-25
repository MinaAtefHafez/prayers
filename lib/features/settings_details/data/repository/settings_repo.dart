import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prayers/core/exceptions/failures.dart';
import 'package:prayers/core/helpers/api_helper/api_consumer.dart';
import 'package:prayers/core/helpers/api_helper/end_points.dart';
import 'package:prayers/core/helpers/hive_helper/hive_helper.dart';
import 'package:prayers/core/helpers/shared_preference/local_storage_keys.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';
import 'package:prayers/features/settings_details/data/models/location_model.dart';
import 'package:prayers/features/settings_details/data/models/methods_model.dart';

abstract class SettingsRepo {
  late Map<dynamic, dynamic>? settingsMap;
  Future<void> saveLocationDataLocal(String locationData);
  Future<Either<Failure, MethodsModel>> getMethods();
  Future<void> saveMethod(String method);
  Future<Algeria> getMothodLocal();
  Future<LocationModel> getLocationLocal();
  Future<void> savePrayersSettingsLocal(Map<dynamic, dynamic> data);
  Future<Map<dynamic, dynamic>?> getPrayersSettingsLocal();
}

class SettingsRepoImpl extends SettingsRepo {
  final ApiConsumer _apiConsumer;

  SettingsRepoImpl(this._apiConsumer);

  @override
  Future<void> saveLocationDataLocal(String locationData) async {
    SharedPref.setValue(LocalStorageKeys.location, value: locationData);
  }

  @override
  Future<Either<Failure, MethodsModel>> getMethods() async {
    try {
      final response = await _apiConsumer.get(url: ApiEndPoints.methods);
      return right(MethodsModel.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }

  @override
  Future<void> saveMethod(String method) async {
    SharedPref.setValue(LocalStorageKeys.method, value: method);
  }

  @override
  Future<Algeria> getMothodLocal() async {
    final result = SharedPref.getValue(LocalStorageKeys.method) as String;

    return Algeria.fromJson(jsonDecode(result));
  }

  @override
  Future<LocationModel> getLocationLocal() {
    final data = SharedPref.getValue(LocalStorageKeys.location) as String;
    return Future.value(LocationModel.fromJson(jsonDecode(data)));
  }

  //! settings

  @override
  Future<void> savePrayersSettingsLocal(Map<dynamic, dynamic> data) async {
    await HiveHelper.putData<Map<dynamic, dynamic>>(
        key: HiveConstants.settings, value: data);
  }

  @override
  Future<Map<dynamic, dynamic>?> getPrayersSettingsLocal() async {
    final data = await HiveHelper.getData(key: HiveConstants.settings)
        as Map<dynamic, dynamic>?;
    super.settingsMap = data;
    return super.settingsMap;
  }
}
