import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/helpers/localization_helper/localization/localization_utils.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/widgets/custom_dialog.dart';
import 'dart:ui' as ui;

void gettingLocationDialog(BuildContext context) {
  CustomDialog.dialog(
     context,
      horizontal: 30.w,
      vertical: 40.h,
      widget: Directionality(
        textDirection: LocalizationUtils.isArabic
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
        child: Row(
          children: [
            const CircularProgressIndicator(color: Colors.black),
            20.0.width,
            Text(tr('GetLocation'),
                style: AppStyles.style18.copyWith(color: Colors.black))
          ],
        ),
      ));
}
