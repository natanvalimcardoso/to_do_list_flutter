import 'package:flutter/material.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/entities/to_do_entity.dart' show ToDoEntity;

class ToDoItemWidget extends StatelessWidget {
  final ToDoEntity todo;
  const ToDoItemWidget({ super.key, required this.todo });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          onChanged: (value) {
          },
        ),
        title: Text(
          todo.todo,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
          },
        ),
        onTap: () {
        },
      ),
    );
  }
}