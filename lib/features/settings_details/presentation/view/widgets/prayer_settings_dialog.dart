import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/core/widgets/custom_dialog.dart';

void prayerSettingsDialog(BuildContext context,
    {required Function(int index) onTap, required List<String> prayers}) {
  CustomDialog.dialog(
    vertical: 30.h,
    context,
    widget: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Text(tr('ChoosePrayer'),
              style: AppStyles.style25.copyWith(color: AppColors.primary)),
        ),
        Divider(color: Colors.grey.shade400, thickness: 0.5, height: 0),
        30.0.height,
        SizedBox(
          height: 400.h,
          child: ListView.separated(
              separatorBuilder: (context, index) => 20.0.height,
              itemCount: prayers.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onTap(index),
                  child: Center(
                    child: Text(tr(prayers[index]),
                        style: AppStyles.style23.copyWith(color: Colors.black)),
                  ),
                );
              }),
        )
      ],
    ),
  );
}
