import '../../../domain/entities/to_do_entity.dart';

class ToDoModel extends ToDoEntity {
  ToDoModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  static List<ToDoModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => ToDoModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': todo,
    'completed': completed,
    'userId': userId,
  };
}
