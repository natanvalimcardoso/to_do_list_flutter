class ToDoEntity {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  ToDoEntity({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  ToDoEntity copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return ToDoEntity(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }
}

//todo: trocar variaveis : todos para ToDos