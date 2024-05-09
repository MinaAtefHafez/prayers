import 'package:easy_localization/easy_localization.dart';

abstract class IntlHelper {
  static String yearNow = DateTime.now().year.toString();
  static String monthNow = DateTime.now().month.toString();
  static String dayNow = DateTime.now().day.toString();

  static String dateAsString([DateTime? dateTime]) =>
      DateFormat('HH:mm').format(dateTime ?? DateTime.now());
  static DateTime dateTime([String? dateTime]) =>
      DateFormat('HH:mm').parse(dateTime ?? dateAsString());
}