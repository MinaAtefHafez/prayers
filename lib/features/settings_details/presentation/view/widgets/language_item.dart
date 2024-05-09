import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem(
      {super.key,
      required this.groupValue,
      required this.onChanged,
      required this.text, required this.value});
  
  final int value ;
  final int groupValue;
  final void Function(int?)? onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Radio<int>(
            activeColor: AppColors.primary,
            value: value ,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          20.0.width,
          Text(tr(text), style: AppStyles.style23.copyWith(fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
