import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_fonts.dart';
import '../../domain/entities/to_do_entity.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoEntity todo;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged;

  const ToDoItemWidget({
    required this.todo,
    required this.onTap,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return Card(
      elevation: isDark ? 0 : 2,
      shadowColor: isDark ? Colors.transparent : AppColors.secondaryText.withValues(alpha: 0.2),
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.007, horizontal: size.width * 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color:
              isDark
                  ? Colors.transparent
                  : todo.completed
                  ? Colors.transparent
                  : AppColors.cardBackgroundLight,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: todo.completed,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
            side: BorderSide(
              color:
                  isDark
                      ? todo.completed
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.primaryTextDark
                      : todo.completed
                      ? Theme.of(context).colorScheme.primary
                      : AppColors.secondaryText,
              width: 1.5,
            ),
            checkColor: AppColors.greenDark,
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (states) =>
                  isDark
                      ? todo.completed
                          ? AppColors.completedGreen
                          : AppColors.primaryTextDark
                      : todo.completed
                      ? AppColors.completedGreen
                      : Colors.transparent,
            ),
          ),
        ),
        title: Text(
          todo.todo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.roboto16w400.copyWith(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color:
                todo.completed
                    ? Theme.of(context).colorScheme.tertiaryFixed
                    : Theme.of(context).colorScheme.tertiaryContainer,
          ),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.005,
        ),
      ),
    );
  }
}
