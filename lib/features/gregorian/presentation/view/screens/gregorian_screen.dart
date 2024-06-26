import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/widgets/custom_indicator.dart';
import 'package:prayers/core/widgets/error_widget.dart';
import 'package:prayers/features/gregorian/presentation/gregorian_cubit/gregorian_cubit.dart';
import 'package:prayers/features/gregorian/presentation/gregorian_cubit/gregorian_state.dart';
import 'package:prayers/features/gregorian/presentation/view/widgets/gregorian_hijri_button.dart';
import 'package:prayers/features/gregorian/presentation/view/widgets/gregorian_top_part.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import '../../../../../core/dependency_injection/dependency_injection.dart';
import '../widgets/gregorian_hijri_list_view.dart';

class GregorianScreen extends StatefulWidget {
  const GregorianScreen({super.key});

  static const name = '/gregorian';

  @override
  State<GregorianScreen> createState() => _GregorianScreenState();
}

class _GregorianScreenState extends State<GregorianScreen> {
  final settingsCubit = di<SettingsCubit>();
  final gregorianCubit = di<GregorianCubit>();

  @override
  void initState() {
    super.initState();
    call();
  }

  void call() async {
    await gregorianCubit.getYearNowLocal();
    await gregorianCubit.getHijriForYearLocal();
    await gregorianCubit.getGregorianForYearApiOrLocal();
    await gregorianCubit.callHijriCalendarApiOrLocal();
    await gregorianCubit.getgregorianMonthNowFromGregorianModel();
    await gregorianCubit.getHijriMonthNowFromHijriModel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: gregorianCubit,
      child: BlocBuilder<GregorianCubit, GregorianState>(
        builder: (context, state) {
          if (gregorianCubit.showMonth != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(settingsCubit.location!.locationName!),
                actions: [
                  GregorianHijriButton(
                      text: 'Gregorian',
                      isChoosen: gregorianCubit.isShowGregorian,
                      onTap: gregorianCubit.chooseGregorianPicker),
                  Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: GregorianHijriButton(
                          isChoosen: gregorianCubit.isShowHijri,
                          text: 'Hijri',
                          onTap: gregorianCubit.chooseHijriPicker)),
                ],
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(170.h),
                    child: GregorianTopPart(
                      back:
                          gregorianCubit.changeToPreviousGregorianOrHijriMonth,
                      next: gregorianCubit.changeToNextGregorianOrHijriMonth,
                      month: gregorianCubit.showMonth!,
                      year: gregorianCubit.showYear!,
                    )),
              ),
              body: GregorianHijriListView(
                isGregorian: gregorianCubit.isShowGregorian,
                list: gregorianCubit.showPrayersList,
              ),
            );
          } else if (state is GetGregorianYearFailure) {
            return CustomErrorWidget(
                message: state.errMessage,
                onPressed: () {
                  gregorianCubit.getGregorianForYear();
                });
          } else if (state is GetHijriCalendarFromApiFailure) {
           return CustomErrorWidget(
                message: state.errMessage,
                onPressed: () {
                  gregorianCubit.getHijriCalendarForYear();
                });
          } else {
            return const CustomIndicator();
          }
        },
      ),
    );
  }
}
