import '../../../data/models/settings_item_model.dart';

abstract class SettingsUiLists {
  static List<String> get prayersNames => [
        'Midnight',
        'Fajr',
        'Dhuhr',
        'Asr',
        'Maghrib',
        'Isha',
      ];

  static List<SettingsItemModel> get settingsItemsModel => [
        SettingsItemModel(title: 'Language', subTitle: 'EditLanguage'),
        SettingsItemModel(
            title: 'ShowPrayers', subTitle: 'ModifyingApparentPrayers'),
        SettingsItemModel(title: 'Method', subTitle: 'MethodWay'),
        SettingsItemModel(
            title: 'PrayersSettings', subTitle: 'PrayerSettingsEdititing'),
        SettingsItemModel(title: 'Location', subTitle: 'LocationSettings'),
      ];
}
