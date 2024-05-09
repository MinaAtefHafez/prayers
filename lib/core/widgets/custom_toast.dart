import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class CustomToast {
  static void showToast(
    String msg, {
    Color? textColor,
    Color? backgroundColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16 ,
        textColor: textColor ?? Colors.black,
        backgroundColor: backgroundColor ?? Colors.lime);
  }
}
