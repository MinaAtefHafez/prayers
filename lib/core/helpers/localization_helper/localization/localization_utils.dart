import 'dart:io';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationUtils {
  static late BuildContext context;

  static  void init(BuildContext cxt) async {
    context = cxt;
  }

  static bool get isArabic { 
    return EasyLocalization.of(context)?.locale.languageCode == "ar";
  }

  static Future<void> changeLocale(String locale) async {
    await context.setLocale(Locale(locale));
  }

  static String get locale {
    return EasyLocalization.of(context)?.locale.languageCode ?? deviceLocale;
  }

  static String get deviceLocale => Platform.localeName.split("_").first;

  static get textDirection =>
      isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr;
}
