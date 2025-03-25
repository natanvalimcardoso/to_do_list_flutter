import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    textTheme: TextTheme(
      titleMedium: AppFonts.roboto18w400.copyWith(color: AppColors.secondaryText),
      bodyMedium: AppFonts.roboto16w500.copyWith(color: AppColors.secondaryTextGreyDart),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardBackgroundLight,
    fontFamily: AppFonts.fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundLight,
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(AppColors.completedGreen),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.accentBlue),
  );

  static ThemeData get dark => ThemeData(
    textTheme: TextTheme(
      titleMedium: AppFonts.roboto18w400.copyWith(color: AppColors.secondaryTextLight),
      bodyMedium: AppFonts.roboto16w500.copyWith(color: AppColors.secondaryTextLight),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardBackgroundDark,
    fontFamily: AppFonts.fontFamily,

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
      iconTheme: IconThemeData(color: AppColors.primaryTextDark),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(AppColors.completedGreen),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.accentBlue),
  );
}
