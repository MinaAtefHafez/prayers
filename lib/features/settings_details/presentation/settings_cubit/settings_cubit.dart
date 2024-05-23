import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:prayers/core/exceptions/exceptions.dart';
import 'package:prayers/core/helpers/location_helper/location_helper.dart';
import 'package:prayers/features/settings_details/data/models/location_model.dart';
import 'package:prayers/features/settings_details/data/models/methods_model.dart';
import 'package:prayers/features/settings_details/data/models/prayer_settings_model.dart';
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
  int prayerEditIndex = 0;

  List<PrayerSettingsModel> prayersSettingsList = [
    PrayerSettingsModel(
        prayerName: 'Midnight', isNotify: true, isShow: true, minutes: 15),
    PrayerSettingsModel(
        prayerName: 'Fajr', isNotify: true, isShow: true, minutes: 15),
    PrayerSettingsModel(
        prayerName: 'Dhuhr', isNotify: true, isShow: true, minutes: 15),
    PrayerSettingsModel(
        prayerName: 'Asr', isNotify: true, isShow: true, minutes: 15),
    PrayerSettingsModel(
        prayerName: 'Maghrib', isNotify: true, isShow: true, minutes: 15),
    PrayerSettingsModel(
        prayerName: 'Isha', isNotify: true, isShow: true, minutes: 15),
  ];

  String get prayerSettingNow => prayerSettings!.prayerName!;

  void choosePrayerToEditSetting(int index) {
    prayerSettings = prayersSettingsList[index];
    emit(ChoosePrayerToEditSettings());
  }

  void recievePrayerEditIndex(int index) {
    prayerEditIndex = index;
  }

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

  @override
  void onChange(Change<SettingsState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
