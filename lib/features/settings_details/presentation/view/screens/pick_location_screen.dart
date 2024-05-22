import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/core/widgets/snack_bar.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/method_screen.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/getting_location_dialog.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/gps_button.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/settings_button.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  static const name = '/pickLocation';

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is GetCurrentLocationFailure) {
            showSnackBar(context, message: state.errMessage);
          }

          if (state is GetCurrentLocationLoading) {
            gettingLocationDialog(context);
          }

          if (state is GetCurrentLocationSuccess) {
            context.pop();
            context.pushNamed(MethodScreen.name);
          }
        },
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tr('DetermineLocation'),
                      style:
                          AppStyles.style35.copyWith(color: AppColors.primary)),
                  50.0.height,
                  GpsButton(
                    onTap: () {
                      settingsCubit.getCurrentLocation();
                    },
                  ),
                  10.0.height,
                  Text(tr('ClickHere'),
                      style: AppStyles.style23.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
