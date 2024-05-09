import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/home/data/models/prayer_model.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({super.key, required this.prayerModel});
  
  final PrayerModel prayerModel ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text( tr(prayerModel.prayerName!) ,
            style: AppStyles.style25
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(prayerModel.prayerDate!.split(' ').first,
            style: AppStyles.style30
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        10.0.height,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade400, width: 2)),
          child: Text('45د',
              style: AppStyles.style18
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
