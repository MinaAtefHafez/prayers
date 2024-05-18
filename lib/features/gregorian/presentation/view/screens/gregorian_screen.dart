import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/widgets/custom_indicator.dart';
import 'package:prayers/features/gregorian/presentation/gregorian_cubit/gregorian_cubit.dart';
import 'package:prayers/features/gregorian/presentation/gregorian_cubit/gregorian_state.dart';
import 'package:prayers/features/gregorian/presentation/view/widgets/gregorian_hijri_button.dart';
import 'package:prayers/features/gregorian/presentation/view/widgets/gregorian_list_view_item.dart';
import 'package:prayers/features/gregorian/presentation/view/widgets/gregorian_top_part.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import '../../../../../core/dependency_injection/dependency_injection.dart';

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
    gregorianCubit.getYearNowLocal().then((value) async {
      await gregorianCubit.getGregorianForYearApiOrLocal();
      await gregorianCubit.getgregorianMonthNowFromGregorianModel();
      await gregorianCubit.getHijriMonthNowFromGregorianModel();
    });
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
                      onTap: ()  {
                        gregorianCubit.chooseGregorianPicker();
                      }),
                  Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: GregorianHijriButton(
                          isChoosen: gregorianCubit.isShowHijri,
                          text: 'Hijri',
                          onTap: ()  {
                            gregorianCubit.chooseHijriPicker();
                          })),
                ],
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(150.h),
                    child: GregorianTopPart(
                      back:
                          gregorianCubit.changeToPreviousGregorianOrHijriMonth,
                      next: gregorianCubit.changeToNextGregorianOrHijriMonth,
                      month: gregorianCubit.showMonth!,
                      year: gregorianCubit.showYear!,
                    )),
              ),
              body: ListView.separated(
                itemCount: gregorianCubit.gregorianYearList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                itemBuilder: (context, index) => GregorianListViewItem(
                    gregorianYear: gregorianCubit.gregorianYearList[index]),
              ),
            );
          } else {
            return const CustomIndicator();
          }
        },
      ),
    );
  }
}
