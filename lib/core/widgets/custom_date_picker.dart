import 'package:flutter/material.dart';
import 'package:prayers/core/helpers/intl_helper/intl_helper.dart';

abstract class CustomDatePicker {
  static Future<DateTime?> datePicker(BuildContext context,
      {DateTime? lastDate, DateTime? firstDate}) async {
    final DateTime? datePicked;
    datePicked = await showDatePicker(
        context: context,
        firstDate: firstDate ?? DateTime.now(),
        initialDate: firstDate ?? DateTime.now(),
        lastDate: DateTime(
            lastDate?.year ?? int.parse(IntlHelper.yearNow),
            lastDate?.month ?? int.parse(IntlHelper.monthNow),
            lastDate?.day ??
                DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
                    .day));
    return datePicked;
  }
}
