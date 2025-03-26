import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool isDark;

  const CustomCheckbox({
    required this.value, super.key,
    this.onChanged,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      side: BorderSide(
        color:
            isDark
                ? (value ? Theme.of(context).colorScheme.primary : AppColors.primaryTextDark)
                : (value ? Theme.of(context).colorScheme.primary : AppColors.secondaryText),
        width: 1.5,
      ),
      checkColor: AppColors.greenDark,
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (states) =>
            isDark
                ? (value ? AppColors.completedGreen : AppColors.primaryTextDark)
                : (value ? AppColors.completedGreen : Colors.transparent),
      ),
    );
  }
}
