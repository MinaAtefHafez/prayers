import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/prayers/presentation/prayers_cubit/prayers_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/settings_show_prayer_item.dart';
import '../../../../../core/dependency_injection/dependency_injection.dart';
import '../../settings_cubit/settings_cubit.dart';
import '../widgets/settings_ui_lists.dart';

class SettingsShowPrayersScreen extends StatefulWidget {
  const SettingsShowPrayersScreen({super.key});

  static const name = '/settingsShowPrayers';

  @override
  State<SettingsShowPrayersScreen> createState() =>
      _SettingsShowPrayersScreenState();
}

class _SettingsShowPrayersScreenState extends State<SettingsShowPrayersScreen> {
  final settingsCubit = di<SettingsCubit>();
  final prayersCubit = di<PrayersCubit>();
  final prayers = SettingsUiLists.prayersNames;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: prayersCubit,
      child: BlocProvider.value(
        value: settingsCubit,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80.h,
              title: Text(tr('ShowPrayers')),
              actions: [
                TextButton(
                    onPressed: () async {
                      await settingsCubit.savePrayersSettingsLocal();
                      await settingsCubit.getPrayersSettingsLocal();
                      prayersCubit.filterPrayersToday().then((value) {
                        context.pop();
                      });
                    },
                    child: Text(
                      tr('Save'),
                      style: AppStyles.style16.copyWith(color: Colors.white),
                    ))
              ],
            ),
            body: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      SettingsShowPrayerItem(
                        prayerName: 'Midnight',
                        value: settingsCubit.settingsPrayerIsShow('Midnight'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Midnight', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Imsak',
                        value: settingsCubit.settingsPrayerIsShow('Imsak'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Imsak', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Fajr',
                        value: settingsCubit.settingsPrayerIsShow('Fajr'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Fajr', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Sunrise',
                        value: settingsCubit.settingsPrayerIsShow('Sunrise'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Sunrise', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Dhuhr',
                        value: settingsCubit.settingsPrayerIsShow('Dhuhr'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Dhuhr', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Asr',
                        value: settingsCubit.settingsPrayerIsShow('Asr'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Asr', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Maghrib',
                        value: settingsCubit.settingsPrayerIsShow('Maghrib'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Maghrib', value: value!),
                      ),
                      20.0.height,
                      SettingsShowPrayerItem(
                        prayerName: 'Isha',
                        value: settingsCubit.settingsPrayerIsShow('Isha'),
                        onChanged: (value) => settingsCubit
                            .changeSettingsIsShow('Isha', value: value!),
                      ),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
