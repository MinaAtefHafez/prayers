import 'package:flutter/material.dart';
import 'package:prayers/features/home/presentation/view/screens/home_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/language_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/method_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/methods_choosen_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/pick_location_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/preyer_settings_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/settings_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/settings_show_prayers_screen.dart';

import '../../features/gregorian/presentation/view/screens/gregorian_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

abstract class CustomRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    final widget = switch (settings.name) {
      MethodChoosenScreen.name => const MethodChoosenScreen(),
      SettingsShowPrayersScreen.name => const SettingsShowPrayersScreen(),
      PrayerSettingsScreen.name => const PrayerSettingsScreen(),
      SettingsScreen.name => const SettingsScreen(),
      GregorianScreen.name => const GregorianScreen(),
      HomeScreen.name => const HomeScreen(),
      MethodScreen.name => const MethodScreen(),
      PickLocationScreen.name => const PickLocationScreen(),
      _ => const LanguageScreen()
    };

    return MaterialPageRoute(builder: (_) => widget);
  }
}
