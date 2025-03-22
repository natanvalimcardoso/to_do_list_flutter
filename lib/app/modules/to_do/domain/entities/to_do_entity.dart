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
}