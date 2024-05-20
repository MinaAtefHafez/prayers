import 'package:easy_localization/easy_localization.dart';

abstract class IntlHelper {
  static String get yearNow => DateTime.now().year.toString();
  static String get monthNow => DateTime.now().month.toString();
  static String get dayNow => DateTime.now().day.toString();

  static String dateAsString([DateTime? dateTime]) => Intl.withLocale(
      'en',
      () => DateFormat.Hm().format(dateTime ?? DateTime.now()));
  static DateTime dateTime([String? dateTime]) => Intl.withLocale(
      'en', () => DateFormat.Hm().parse(dateTime ?? dateAsString()));
}
