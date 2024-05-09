import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/home/data/models/prayer_model.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({super.key, required this.prayerModel , 
    this.isPrayerNext = false
  });
  
  final PrayerModel prayerModel ;
  final bool isPrayerNext ;

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
        IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade400, width: 2)),
            child: Visibility(
              visible: isPrayerNext,
              replacement: Text( '${tr('Since')} ${prayerModel.differnece!}${tr('Min')}' ,
                style: AppStyles.style18
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
              child: Text( '${prayerModel.differnece!}${tr('Min')}' ,
                style: AppStyles.style18
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),  
              ),
          ),
        ),
      ],
    );
  }
}
