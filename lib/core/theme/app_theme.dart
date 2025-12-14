import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,

    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll((AppColors.black)),
      overlayColor: WidgetStatePropertyAll((AppColors.black)),
    ),

    cardTheme: CardThemeData(
      margin: EdgeInsets.all(20),
      color: AppColors.white,
      shadowColor: AppColors.gray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    )
  );
}
