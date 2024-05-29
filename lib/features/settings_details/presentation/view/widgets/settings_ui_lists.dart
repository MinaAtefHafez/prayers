import 'package:flutter/material.dart';

import '../../../data/models/settings_item_model.dart';

abstract class SettingsUiLists {
  static List<String> get prayersNames => [
        'Midnight',
        'Imsak' ,
        'Sunrise',
        'Fajr',
        'Dhuhr',
        'Asr',
        'Maghrib',
        'Isha',
      ];

  static List<SettingsItemModel> get settingsItemsModel => [
        SettingsItemModel(
            title: 'Language',
            subTitle: 'EditLanguage',
            iconData: Icons.language),
        SettingsItemModel(
            title: 'ShowPrayers',
            subTitle: 'ModifyingApparentPrayers',
            iconData: Icons.alarm),
        SettingsItemModel(
            title: 'Method', subTitle: 'MethodWay', iconData: Icons.ac_unit),
        SettingsItemModel(
            title: 'PrayersSettings',
            subTitle: 'PrayerSettingsEdititing',
            iconData: Icons.settings),
        SettingsItemModel(
            title: 'Location',
            subTitle: 'LocationSettings',
            iconData: Icons.location_on),
      ];
}
