import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.message, this.onPressed});

  final String message;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 150.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r), color: Colors.red),
              child: Text(message,
                  style: AppStyles.style18.copyWith(color: Colors.black)),
            ),
            30.0.height,
            if (onPressed != null) ...[
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: Text(tr('Reload'),
                    style: AppStyles.style18.copyWith(color: Colors.white)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
