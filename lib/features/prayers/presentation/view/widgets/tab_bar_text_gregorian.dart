import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';

class TabBarTextGregorian extends StatelessWidget {
  const TabBarTextGregorian({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.w,
      alignment: Alignment.center,
      child: FittedBox(
        child: Text(tr(text),
            style: AppStyles.style18.copyWith(color: Colors.white)),
      ),
    );
  }
}
