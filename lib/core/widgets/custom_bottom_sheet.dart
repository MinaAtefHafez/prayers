import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void customBottomSheet(BuildContext context, {required Widget widget}) {
  showBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade200,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          borderSide: BorderSide.none),
      elevation: 0,
      enableDrag: true ,
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.7,
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: double.infinity,
          minWidth: double.infinity),
      builder: (context) => widget);
}
