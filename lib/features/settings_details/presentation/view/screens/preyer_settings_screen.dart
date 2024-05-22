import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

class PrayerSettingsScreen extends StatefulWidget {
  const PrayerSettingsScreen({super.key});

  static const name = '/prayer_settings';

  @override
  State<PrayerSettingsScreen> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettingsScreen> {
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(settingsCubit.prayerSettingNow)),
        toolbarHeight: 80.h,
      ),
    );
  }
}
