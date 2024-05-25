import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';

class SettingsShowPrayerItem extends StatelessWidget {
  const SettingsShowPrayerItem(
      {super.key,
      required this.prayerName,
      required this.value,
      this.onChanged});

  final String prayerName;
  final bool value;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(tr(prayerName),
            style: AppStyles.style20
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
        const Spacer(),
        Checkbox(
          value: value,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
