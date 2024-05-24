import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/core/widgets/custom_indicator.dart';
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

  final prayers = SettingsUiLists.prayersNames;

  @override
  void initState() {
    super.initState();
    settingsCubit.getPrayersSettingsLocal();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SavePrayersSettingsLocal) {
            context.pop();
          }
        },
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80.h,
              title: Text(tr('ShowPrayers')),
              actions: [
                TextButton(
                    onPressed: () {
                      settingsCubit.savePrayersSettingsLocal();
                    },
                    child: Text(
                      tr('Save'),
                      style: AppStyles.style16.copyWith(color: Colors.white),
                    ))
              ],
            ),
            body: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
              if (state is GetPrayersSettingsLocalLoading) {
                return const CustomIndicator();
              } else {
                return ListView.builder(
                  itemCount: prayers.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                    child: Row(
                      children: [
                        Text(tr(prayers[index]),
                            style: AppStyles.style20.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Checkbox(
                          value: settingsCubit.prayerSettingsIsShow(index),
                          activeColor: AppColors.primary,
                          onChanged: (value) => settingsCubit
                              .changePrayerShow(index, value: value!),
                        ),
                      ],
                    ),
                  ),
                );
              }
            })),
      ),
    );
  }
}
