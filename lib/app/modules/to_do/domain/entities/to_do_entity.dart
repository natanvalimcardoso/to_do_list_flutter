import 'package:equatable/equatable.dart';

class ToDoEntity extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const ToDoEntity({required this.id, required this.todo, required this.completed, required this.userId});

  ToDoEntity copyWith({int? id, String? todo, bool? completed, int? userId}) {
    return ToDoEntity(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [id, todo, completed, userId];
}

