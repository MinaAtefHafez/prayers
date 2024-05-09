import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';

class MethodItem extends StatelessWidget {
  const MethodItem(
      {super.key,
      required this.methodName,
      required this.fajr,
      required this.isha});

  final String methodName;
  final String fajr;
  final String isha;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(methodName,
            style: AppStyles.style18.copyWith(color: Colors.black)),
        5.0.height,
        Row(children: [
          Text(tr('Fajr'),
              style: AppStyles.style16.copyWith(color: Colors.grey)),
          Text(' : $fajr',
              style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          4.0.width,
          Text(',', style: AppStyles.style18.copyWith(color: Colors.black)),
          4.0.width,
          Text(tr('Isha'),
              style: AppStyles.style16.copyWith(color: Colors.grey)),
          Text(' : $fajr',
              style: AppStyles.style16.copyWith(color: Colors.grey.shade500)),
          
        ]),
        
          const Divider(color: Colors.black, thickness: 0.5),
      ],
    );
  }
}
