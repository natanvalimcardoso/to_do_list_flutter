import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_fonts.dart';
import '../../domain/entities/to_do_entity.dart';
import 'custom_checkbox_widget.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoEntity todo;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;

  const ToDoItemWidget({
    required this.todo,
    required this.onTap,
    required this.onChanged,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return Card(
      elevation: isDark || todo.completed ? 0 : 2,
      shadowColor:
          isDark || todo.completed
              ? Colors.transparent
              : AppColors.secondaryText.withValues(alpha: 0.2),
      color:
          isDark && todo.completed
              ? AppColors.cardBackgroundDark.withValues(alpha: 0.2)
              : Theme.of(context).cardColor,
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
          child: CustomCheckbox(value: todo.completed, onChanged: onChanged),
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
        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: onDelete),
      ),
    );
  }
}
