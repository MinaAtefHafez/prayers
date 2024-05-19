import 'package:jhijri/jHijri.dart';

abstract class HijriHelper {
  static String get hijriYearNow => JHijri.now().year.toString();

  static String get hijriMonthNow => JHijri.now().month.toString();

  static String get hijriDayNow => JHijri.now().day.toString();
}
