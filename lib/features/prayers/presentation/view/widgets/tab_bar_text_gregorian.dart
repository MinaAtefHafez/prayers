import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';

class TabBarTextGregorian extends StatelessWidget {
  const TabBarTextGregorian({super.key, required this.text});

  final String text ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(tr(text),
          style: AppStyles.style18.copyWith(color: Colors.white)),
    );
  }
}
