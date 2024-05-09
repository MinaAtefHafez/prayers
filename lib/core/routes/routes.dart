import 'package:flutter/material.dart';
import 'package:prayers/features/home/presentation/view/screens/home_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/language_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/method_screen.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/pick_location_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

abstract class CustomRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    final widget = switch (settings.name) {
      HomeScreen.name => const HomeScreen(),
      MethodScreen.name => const MethodScreen(),
      PickLocationScreen.name => const PickLocationScreen(),
      _ => const LanguageScreen()
    };

    return MaterialPageRoute(builder: (_) => widget);
  }
}