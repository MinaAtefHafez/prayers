import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.text,required this.onPressed});

  final String text;
  final  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(100.w, 50.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r))),
        onPressed: onPressed,
        child: Text(text,
            style: AppStyles.style18.copyWith(color: AppColors.primary)));
            
  }
}
