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
    cardColor: Colors.white,
    fontFamily: AppFonts.fontFamily,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundLight,
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentBlue,
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.accentBlue,
      secondary: AppColors.accentBlue,
      surface: AppColors.cardBackgroundLight,
      error: Colors.red,
      onSecondary: Colors.white,
      tertiaryContainer: AppColors.primaryText,
      tertiaryFixed: AppColors.secondaryText,
    ),
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

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
      iconTheme: IconThemeData(color: AppColors.primaryTextDark),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentBlue,
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.accentBlue,
      secondary: AppColors.accentBlue,
      surface: AppColors.cardBackgroundDark,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      tertiaryContainer: AppColors.cardBackgroundLight,
      tertiaryFixed: AppColors.secondaryText,
    ),
  );
}
