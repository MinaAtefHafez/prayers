import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/features/settings_details/data/models/settings_item_model.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({super.key, required this.settingsItemModel});

  final SettingsItemModel settingsItemModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tr(settingsItemModel.title),
          style: AppStyles.style18
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
      subtitle: Text(
        tr(settingsItemModel.subTitle),
        style: AppStyles.style16
            .copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w400),
      ),
      leading: settingsItemModel.iconData != null
          ? Icon(settingsItemModel.iconData,
              color: AppColors.primary, size: 25.w)
          : null,
    );
  }
}
