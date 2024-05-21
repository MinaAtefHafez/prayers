import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/assets_images.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/gen/app_images.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/widgets/custom_date_picker.dart';
import 'package:prayers/core/widgets/custom_indicator.dart';
import 'package:prayers/core/widgets/custom_toast.dart';
import 'package:prayers/core/widgets/error_widget.dart';
import 'package:prayers/core/widgets/snack_bar.dart';
import 'package:prayers/features/prayers/presentation/prayers_cubit/prayers_cubit.dart';
import 'package:prayers/features/prayers/presentation/view/widgets/prayers_list_view.dart';
import 'package:prayers/features/prayers/presentation/view/widgets/today_item.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/getting_location_dialog.dart';
import '../../../../../core/theme/colors/colors.dart';
import '../widgets/prayer_item.dart';
import '../../../../gregorian/presentation/view/screens/gregorian_screen.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final prayersCubit = di<PrayersCubit>();
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: prayersCubit,
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

          if (state is GetCurrentLocationFailure) {
            showSnackBar(context, message: state.errMessage);
          }
        }, child: BlocBuilder<PrayersCubit, PrayersState>(
          builder: (context, state) {
            if (prayersCubit.prayerToday != null) {
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
                              Row(
                                children: [
                                  Icon(Icons.location_city,
                                      color: Colors.grey.shade300),
                                  15.0.width,
                                  Text(settingsCubit.location!.locationName!,
                                      style: AppStyles.style20.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
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
                              if (prayersCubit.previousPrayer != null) ...[
                                Expanded(
                                  child: PrayerItem(
                                      isPrayerNow:
                                          prayersCubit.isPraviousPrayerNow,
                                      prayerModel:
                                          prayersCubit.previousPrayer!),
                                ),
                              ] else ...[
                                const Expanded(child: SizedBox())
                              ],
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.w, vertical: 10.h),
                                  child: SizedBox(
                                    width: 140.w,
                                    height: 140.h,
                                    child: CircleAvatar(
                                      radius: 70.r,
                                      backgroundImage:
                                          Assets.imagesPrayer.imageProv(),
                                    ),
                                  )),
                              if (prayersCubit.nextPrayer != null) ...[
                                Expanded(
                                  child: PrayerItem(
                                      isPrayerNow:
                                          !prayersCubit.isPraviousPrayerNow,
                                      isPrayerNext: true,
                                      prayerModel: prayersCubit.nextPrayer!),
                                ),
                              ] else ...[
                                const Expanded(child: SizedBox())
                              ],
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.r)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13.h, horizontal: 30.w),
                                  child: TodayItem(
                                      prayerToday:
                                          prayersCubit.prayerToday!.date!,
                                      onTapToday: callDatePicker,
                                      onTapIcon: () {
                                        context.pushNamed(GregorianScreen.name);
                                      }),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.7),
                                  thickness: 0.5,
                                  height: 0,
                                ),
                                Expanded(
                                    child: PrayersListView(
                                        isPrayersForToday:
                                            prayersCubit.isPrayersForToday,
                                        prayerState:
                                            prayersCubit.getPrayerState,
                                        prayers: prayersCubit
                                            .prayerToday!.timings!.prayers)),
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
                  message: state.errMessage,
                  onPressed: () {
                    prayersCubit.getCalendarMonth();
                  });
            } else {
              return const CustomIndicator();
            }
          },
        )),
      ),
    );
  }

  void callDatePicker() async {
    final datePick = await CustomDatePicker.datePicker(context);
    if (datePick != null) {
      await prayersCubit.getPrayers(datePick.day.toString());
    }
  }
}
