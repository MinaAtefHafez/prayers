import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/features/gregorian/data/models/gregorian_year_model.dart';

class GregorianListViewItem extends StatelessWidget {
  const GregorianListViewItem({super.key, required this.gregorianYear});

  final GregorianYear gregorianYear;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 60.h,
        child: Row(children: [
          Container(
            width: 55.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
            ),
            child: Builder(builder: (context) {
              final day = gregorianYear.date!.gregorian!.day!.split('').first;
              final dayRefactor = day == '0'
                  ? gregorianYear.date!.gregorian!.day!.split('').last
                  : gregorianYear.date!.gregorian!.day!;
              return Text(dayRefactor,
                  style: AppStyles.style18.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ));
            }),
          ),
          Expanded(
              child: Center(
            child: Text(gregorianYear.timings!.fajr!.split(' ').first,
                style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          )),
          Expanded(
              child: Center(
            child: Text(gregorianYear.timings!.dhuhr!.split(' ').first,
                style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          )),
          Expanded(
              child: Center(
            child: Text(gregorianYear.timings!.asr!.split(' ').first,
                style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          )),
          Expanded(
              child: Center(
            child: Text(gregorianYear.timings!.maghrib!.split(' ').first,
                style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          )),
          Expanded(
              child: Center(
            child: Text(gregorianYear.timings!.isha!.split(' ').first,
                style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          )),
        ]));
  }
}
