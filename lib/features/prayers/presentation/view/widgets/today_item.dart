import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prayers/core/helpers/localization_helper/localization/localization_utils.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/prayers/data/models/calendar_month_model.dart';

class TodayItem extends StatelessWidget {
  const TodayItem({
    super.key,
    required this.onTapToday,
    required this.onTapIcon,
    required this.prayerToday,
  });

  final Function() onTapToday;
  final Function() onTapIcon;
  final Date prayerToday;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTapToday,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    final day =
                        prayerToday.gregorian!.day!.split('').first == '0'
                            ? prayerToday.gregorian!.day!.split('').last
                            : prayerToday.gregorian!.day!;
                    return Text(
                      '${tr('${prayerToday.gregorian!.weekday!.en}')} , $day ${tr(prayerToday.gregorian!.month!.en!)} ${prayerToday.gregorian!.year}',
                      style: AppStyles.style18.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    );
                  }),
                  Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
                ],
              ),
              Builder(builder: (context) {
                final day = prayerToday.hijri!.day!.split('').first == '0'
                    ? prayerToday.hijri!.day!.split('').last
                    : prayerToday.hijri!.day!;
                final month = LocalizationUtils.isArabic
                    ? prayerToday.hijri!.month!.ar
                    : prayerToday.hijri!.month!.en;
                return Text('$day $month ${prayerToday.hijri!.year}',
                    style: AppStyles.style16.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600));
              })
            ],
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: onTapIcon, icon: const Icon(Icons.calendar_month)),
      ],
    );
  }
}
