import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/helpers/localization_helper/localization/localization_utils.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/pick_location_screen.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/language_item.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/settings_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  static const name = '/language';

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: Scaffold(
        body: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is LanguageRadio) {
              if (state.languageRadioValue == 0) {
                LocalizationUtils.changeLocale('ar');
              } else {
                LocalizationUtils.changeLocale('en');
              }
            }
          },
          builder: (context, state) => Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tr('ChooseLanguage'),
                        style: AppStyles.style35
                            .copyWith(color: AppColors.primary)),
                    40.0.height,
                    LanguageItem(
                        value: 0,
                        groupValue: settingsCubit.languageRadioValue,
                        onChanged: settingsCubit.changeLanguageRadioValue,
                        text: 'العربية'),
                    30.0.height,
                    LanguageItem(
                        value: 1,
                        groupValue: settingsCubit.languageRadioValue,
                        onChanged: settingsCubit.changeLanguageRadioValue,
                        text: 'English'),
                    70.0.height,
                    SettingsButton(
                        text: 'Next',
                        onPressed: () {
                          context.pushNamed(PickLocationScreen.name);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
