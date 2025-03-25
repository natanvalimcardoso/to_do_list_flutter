import 'package:flutter/material.dart';
import '../../domain/entities/to_do_entity.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoEntity todo;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged;

  const ToDoItemWidget({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
      ),
      child: ListTile(
        leading: Transform.scale(
          scale: 1.3, 
          child: Checkbox(
            value: todo.completed,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99), 
            ),
            side: BorderSide(
              color: todo.completed ? Theme.of(context).colorScheme.primary : Colors.grey,
              width: 1.5,
            ),
            checkColor: Colors.white,
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (states) =>
                  todo.completed ? Theme.of(context).colorScheme.primary : Colors.transparent,
            ),
          ),
        ),
        title: Text(
          todo.todo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        minLeadingWidth: 10,
      ),
    );
  }
}
