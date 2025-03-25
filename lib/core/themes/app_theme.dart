import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardBackgroundLight,
    fontFamily: AppFonts.fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundLight,
      titleTextStyle: AppFonts.sectionTitle(false),
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(AppColors.completedGreen),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.accentBlue),
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardBackgroundDark,
    fontFamily: AppFonts.fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
      titleTextStyle: AppFonts.sectionTitle(true),
      iconTheme: IconThemeData(color: AppColors.primaryTextDark),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(AppColors.completedGreen),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.accentBlue),
  );
}
