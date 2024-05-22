part of 'settings_cubit.dart';

abstract class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class LanguageRadio extends SettingsState {
  final int languageRadioValue;

  LanguageRadio(this.languageRadioValue);
}

//! location

final class GetCurrentLocationLoading extends SettingsState {}

final class GetCurrentLocationSuccess extends SettingsState {
  final String? location;

  GetCurrentLocationSuccess([this.location]);
}

final class GetCurrentLocationFailure extends SettingsState {
  final String errMessage;

  GetCurrentLocationFailure(this.errMessage);
}

final class GetLocationLoading extends SettingsState {}

final class GetLocationLocalSuccess extends SettingsState {
  GetLocationLocalSuccess();
}

//! methods

final class GetMethodsFromApiLoading extends SettingsState {}

final class GetMethodsFromApiSuccess extends SettingsState {}

final class GetMethodsFromApiFailure extends SettingsState {
  final String errMessage;

  GetMethodsFromApiFailure(this.errMessage);
}

final class ChooseMethod extends SettingsState {}

final class SaveMethodLocalLoading extends SettingsState {}

final class SaveMethodLocalSuccess extends SettingsState {}

//! Settings

final class ChoosePrayerToEditSettings extends SettingsState {}
