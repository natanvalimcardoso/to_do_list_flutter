import 'package:equatable/equatable.dart';
import 'to_do_entity.dart';

class ToDoDetailsEntity extends Equatable {
  final ToDoEntity todo;

  const ToDoDetailsEntity({required this.todo});

  @override
  List<Object?> get props => [todo];
}
