import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CustomDialog {
  static void dialog(BuildContext context,
      {required Widget widget, double? horizontal, double? vertical}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontal ?? 10, vertical: vertical ?? 10),
          child: widget,
        ),
      ),
    );
  }
}
