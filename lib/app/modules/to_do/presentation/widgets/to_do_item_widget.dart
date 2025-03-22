import 'package:flutter/material.dart';
import '../../domain/entities/to_do_entity.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoEntity todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onChanged;

  const ToDoItemWidget({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          onChanged: onChanged,
        ),
        title: Text(
          todo.todo,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}