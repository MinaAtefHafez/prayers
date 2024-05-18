import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';

class GregorianHijriButton extends StatelessWidget {
  const GregorianHijriButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isChoosen});

  final String text;
  final Function() onTap;
  final bool isChoosen;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
        decoration: BoxDecoration(
          boxShadow: isChoosen == true
              ? [
                  const BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Colors.white,
                      blurRadius: 15)
                ]
              : [],
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Text(tr(text),
            style: AppStyles.style16
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
