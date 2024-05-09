import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';

class MethodTextField extends StatelessWidget {
  const MethodTextField(
      {super.key,
       required this.textEditingController ,
      required this.label,
      required this.onTap});

  final TextEditingController textEditingController ;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: textEditingController ,
      readOnly: true ,
      decoration: InputDecoration(
          labelText: tr(label),
          labelStyle: AppStyles.style18.copyWith(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.7))) ,
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.7))) , 
              ),
    );
  }
}
