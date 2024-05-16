import 'package:flutter/material.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';

abstract class AppTheme {
  static ThemeData theme() => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary ,
          titleSpacing: 0 ,
          elevation: 0 ,
          iconTheme: const IconThemeData(color: Colors.white )  ,
          titleTextStyle: AppStyles.style20.copyWith(color: Colors.white ,
           fontWeight: FontWeight.bold 
          )
        ) 
      );
}
