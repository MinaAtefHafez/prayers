import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/assets_images.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/gen/app_images.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/widgets/custom_toast.dart';
import 'package:prayers/core/widgets/error_widget.dart';
import 'package:prayers/core/widgets/shimmer.dart';
import 'package:prayers/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:prayers/features/home/presentation/view/widgets/prayers_list_view.dart';
import 'package:prayers/features/home/presentation/view/widgets/today_item.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/getting_location_dialog.dart';
import '../../../../../core/theme/colors/colors.dart';
import '../widgets/prayer_item.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final homeCubit = di<HomeCubit>();
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: BlocProvider.value(
        value: settingsCubit,
        child: BlocListener<SettingsCubit, SettingsState>(
            listener: (context, state) {
          if (state is GetCurrentLocationLoading) {
            gettingLocationDialog(context);
          }

          if (state is GetCurrentLocationSuccess) {
            context.pop();
            CustomToast.showToast(state.location!);
          }
        }, child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (homeCubit.previousPrayer != null) {
              return Stack(
                children: [
                  Container(color: AppColors.primary),
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              BlocBuilder<SettingsCubit, SettingsState>(
                                  builder: (context, state) {
                                if (settingsCubit.location != null) {
                                  return Row(
                                    children: [
                                      Text(
                                          settingsCubit.location!.locationName!,
                                          style: AppStyles.style20.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                      const Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                    ],
                                  );
                                } else {
                                  return ShimmerWidget.rectangular(
                                      width: 150.w, height: 35.h);
                                }
                              }),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    settingsCubit.getCurrentLocation();
                                  },
                                  icon: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                    size: 30.w,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          alignment: Alignment.center,
                          height: 250.h,
                          color: AppColors.primary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrayerItem(
                                  prayerModel: homeCubit.previousPrayer!),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.w, vertical: 10.h),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.r),
                                    child: Assets.imagesSplash.image()),
                              )),
                              PrayerItem(prayerModel: homeCubit.previousPrayer!)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40.r)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.h, horizontal: 30.w),
                                  child: TodayItem(
                                      prayerToday: homeCubit.prayerToday!.date!,
                                      onTapToday: () {},
                                      onTapIcon: () {}),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.7),
                                  thickness: 0.5,
                                  height: 0,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: PrayersListView(
                                      prayers: homeCubit
                                          .prayerToday!.timings!.prayers),
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is GetCalendarMonthFailure) {
              return CustomErrorWidget(
                  message: state.errMessage, onPressed: () {});
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            }
          },
        )),
      ),
    );
  }
}
