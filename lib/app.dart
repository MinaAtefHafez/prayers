import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/helpers/shared_preference/local_storage_keys.dart';
import 'package:prayers/core/helpers/shared_preference/shared_preference.dart';
import 'package:prayers/core/routes/routes.dart';
import 'package:prayers/core/theme/app_theme.dart';
import 'package:prayers/features/settings_details/presentation/view/screens/language_screen.dart';
import 'core/helpers/localization_helper/localization/localization_utils.dart';
import 'features/home/presentation/view/screens/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 928),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        LocalizationUtils.init(context);
        LocalizationUtils.changeLocale('ar');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SharedPref.getValue(LocalStorageKeys.location) != null
              ? HomeScreen.name
              : LanguageScreen.name,
          onGenerateRoute: CustomRouter.onGenerateRoutes,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.theme(),
        );
      },
    );
  }
}
