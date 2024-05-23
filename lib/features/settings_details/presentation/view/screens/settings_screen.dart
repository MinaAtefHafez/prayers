import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/features/settings_details/data/models/settings_item_model.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/settings_list_tile.dart';

import '../widgets/change_language_dialog.dart';
import '../widgets/prayer_settings_dialog.dart';
import 'preyer_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const name = 'settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsCubit = di<SettingsCubit>();

  final settingsItems = [
    SettingsItemModel(title: 'Language', subTitle: 'EditLanguage'),
    SettingsItemModel(
        title: 'ShowPrayers', subTitle: 'ModifyingApparentPrayers'),
    SettingsItemModel(title: 'Method', subTitle: 'MethodWay'),
    SettingsItemModel(
        title: 'PrayersSettings', subTitle: 'PrayerSettingsEdititing'),
    SettingsItemModel(title: 'Location', subTitle: 'LocationSettings'),
  ];

  final prayers = [
    'Midnight',
    'Fajr',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is LanguageRadio) {
            context.pop();
          }

          if (state is ChoosePrayerToEditSettings) {
            context.pop();
            context.pushNamed(PrayerSettingsScreen.name);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr('Settings')),
            toolbarHeight: 80.h,
          ),
          body: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        changeLanguageDialog(context,
                            groupedValue: settingsCubit.languageRadioValue,
                            onChanged: settingsCubit.changeLanguageRadioValue);
                      },
                      child: SettingsListTile(
                          settingsItemModel: settingsItems[0])),
                  15.0.height,
                  InkWell(
                      onTap: () {},
                      child: SettingsListTile(
                          settingsItemModel: settingsItems[1])),
                  15.0.height,
                  InkWell(
                      onTap: () {},
                      child: SettingsListTile(
                          settingsItemModel: settingsItems[2])),
                  15.0.height,
                  InkWell(
                      onTap: () {
                        prayerSettingsDialog(context, prayers: prayers,
                            onTap: (index) {
                          settingsCubit.recievePrayerEditIndex(index);
                          settingsCubit.choosePrayerToEditSetting(index);
                        });
                      },
                      child: SettingsListTile(
                          settingsItemModel: settingsItems[3])),
                  InkWell(
                      onTap: () {},
                      child: SettingsListTile(
                          settingsItemModel: settingsItems[4])),
                  20.0.height,
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 15.h,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
