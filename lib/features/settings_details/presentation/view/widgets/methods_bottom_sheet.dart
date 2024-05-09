import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/core/widgets/custom_bottom_sheet.dart';
import 'package:prayers/features/settings_details/data/models/methods_model.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/method_item.dart';

void methodBottomSheet(BuildContext context,
    {required MethodsModel methodsModel,
    required Function(Algeria methodChoosen) onTap}) {
  customBottomSheet(
    context,
    widget: Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        children: [
          Text(tr('Method'),
              style: AppStyles.style23.copyWith(color: AppColors.primary)),
          40.0.height,
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final methodModel = methodsModel.data!.methods[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: InkWell(
                    onTap: () {
                      context.pop();
                      onTap(methodModel);
                    },
                    child: MethodItem(
                      fajr: methodModel.params.fajr.toString(),
                      isha: methodModel.params.isha.toString(),
                      methodName: methodModel.name.toString(),
                    ),
                  ),
                );
              },
              itemCount: methodsModel.data!.methods.length,
            ),
          ),
        ],
      ),
    ),
  );
}
