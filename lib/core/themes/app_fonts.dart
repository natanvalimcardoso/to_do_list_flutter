import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFonts {
  static const fontFamily = 'Roboto';

  static TextStyle sectionTitle(bool isDark) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.secondaryTextDark : AppColors.secondaryText,
        fontFamily: fontFamily,
      );

  static TextStyle todoItem(bool isDark, {bool completed = false}) => TextStyle(
        fontSize: 16,
        color: isDark ? AppColors.primaryTextDark : AppColors.primaryText,
        decoration: completed ? TextDecoration.lineThrough : null,
        fontFamily: fontFamily,
      );
}