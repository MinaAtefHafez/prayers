import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/widgets/custom_dialog.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/language_item.dart';

void changeLanguageDialog(BuildContext context,
    {required void Function(int?)? onChanged, required int groupedValue}) {
  CustomDialog.dialog(context,
      horizontal: 30.w,
      vertical: 40.h,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tr('ChooseLanguage'),
              style: AppStyles.style25.copyWith(color: Colors.black)),
          40.0.height,
          LanguageItem(
              value: 0,
              groupValue: groupedValue,
              onChanged: onChanged,
              text: 'العربية'),
          40.0.height,
          LanguageItem(
              value: 1,
              groupValue: groupedValue,
              onChanged: onChanged,
              text: 'English'),
        ],
      ));
}
