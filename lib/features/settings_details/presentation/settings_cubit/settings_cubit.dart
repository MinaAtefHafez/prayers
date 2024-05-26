import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:prayers/core/exceptions/exceptions.dart';
import 'package:prayers/core/helpers/location_helper/location_helper.dart';
import 'package:prayers/features/settings_details/data/models/location_model.dart';
import 'package:prayers/features/settings_details/data/models/methods_model.dart';
import 'package:prayers/features/settings_details/data/models/prayer_settings_model/prayer_settings_model.dart';
import 'package:prayers/features/settings_details/data/repository/settings_repo.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepo) : super(SettingsInitial());

  int languageRadioValue = 0;
  final SettingsRepo _settingsRepo;

  LocationModel? location;
  MethodsModel? methodsModel;
  Algeria? method;

  //! prayer settings

  PrayerSettingsModel? prayerSettings;

  Map<dynamic, dynamic> prayersSettingsMap = {
    'Midnight': PrayerSettingsModel(
        prayerName: 'Midnight', isNotify: true, isShow: true, minutes: 15),
    'Imsak': PrayerSettingsModel(
        prayerName: 'Imsak', isNotify: true, isShow: true, minutes: 15),
    'Sunrise': PrayerSettingsModel(
        prayerName: 'Midnight', isNotify: true, isShow: true, minutes: 15),
    'Fajr': PrayerSettingsModel(
        prayerName: 'Fajr', isNotify: true, isShow: true, minutes: 15),
    'Dhuhr': PrayerSettingsModel(
        prayerName: 'Dhuhr', isNotify: true, isShow: true, minutes: 15),
    'Asr': PrayerSettingsModel(
        prayerName: 'Asr', isNotify: true, isShow: true, minutes: 15),
    'Maghrib': PrayerSettingsModel(
        prayerName: 'Maghrib', isNotify: true, isShow: true, minutes: 15),
    'Isha': PrayerSettingsModel(
        prayerName: 'Isha', isNotify: true, isShow: true, minutes: 15),
  };

  Map<dynamic, dynamic> get getSettingsMap => prayersSettingsMap;

  bool settingsPrayerIsShow(String prayerName) =>
      prayersSettingsMap[prayerName]!.isShow!;

  void changeSettingsIsShow(String prayerName, {required bool value}) {
    prayersSettingsMap[prayerName] =
        prayersSettingsMap[prayerName]!.copyWith(isShow: value);
    emit(ChangePrayerShow());
  }

  String get prayerSettingName => prayerSettings!.prayerName!;

  Future<void> savePrayersSettingsLocal() async {
    await _settingsRepo.savePrayersSettingsLocal(prayersSettingsMap);
    emit(SavePrayersSettingsLocal());
  }

  Future<void> getPrayersSettingsLocal() async {
    emit(GetPrayersSettingsLocalLoading());
    final result = await _settingsRepo.getPrayersSettingsLocal();
    if (result != null) {
      prayersSettingsMap = result;
    }
    emit(GetPrayersSettingsLocal());
  }

  //! language

  void changeLanguageRadioValue(int? value) {
    languageRadioValue = value!;
    emit(LanguageRadio(value));
  }

  //! location

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoading());
    try {
      LocationData locationData = await LocationHelper.getLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);
      location = LocationModel.fromLocationData(locationData);
      location = location!.copyWith(locationName: placemarks[0].locality);
      await saveLocationDataLocal();
      emit(GetCurrentLocationSuccess(location!.locationName!));
    } on LocationException catch (e) {
      emit(GetCurrentLocationFailure(e.errMessage));
    }
  }

  Future<void> saveLocationDataLocal() async {
    String locationData = jsonEncode(location!.toJson());
    _settingsRepo.saveLocationDataLocal(locationData);
    getLocationLocal();
  }

  Future<void> getLocationLocal() async {
    emit(GetLocationLoading());
    location = await _settingsRepo.getLocationLocal();
    emit(GetLocationLocalSuccess());
  }

  //! methods

  Future<void> getMethods() async {
    emit(GetMethodsFromApiLoading());
    final result = await _settingsRepo.getMethods();
    result.fold((failure) {
      emit(GetMethodsFromApiFailure(failure.message));
    }, (model) {
      methodsModel = model;
      method = model.data!.getEgypt;
      emit(GetMethodsFromApiSuccess());
    });
  }

  Future<void> chooseMethod(Algeria methodChoosen) async {
    method = methodChoosen;
    emit(ChooseMethod());
  }

  Future<void> saveMethodLocal() async {
    emit(SaveMethodLocalLoading());
    _settingsRepo.saveMethod(jsonEncode(method!.toJson()));
    emit(SaveMethodLocalSuccess());
  }

  Future<void> getMothodLocal() async {
    method = await _settingsRepo.getMothodLocal();
  }
}
