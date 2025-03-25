import 'package:equatable/equatable.dart';
import '../../domain/entities/to_do_entity.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends ToDoEvent {
  const LoadTodosEvent();
}

class AddToDoEvent extends ToDoEvent {
  final String text;
  const AddToDoEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class DeleteToDoEvent extends ToDoEvent {
  final int id;
  const DeleteToDoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleToDoEvent extends ToDoEvent {
  final int id;
  final bool completed;
  const ToggleToDoEvent({required this.id, required this.completed});

  @override
  List<Object?> get props => [id, completed];
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDoEntity todo;
  const UpdateToDoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class AddAllToDosEvent extends ToDoEvent {
  final List<ToDoEntity> todos;
  const AddAllToDosEvent(this.todos);

  @override
  List<Object?> get props => [todos];
}

class SyncToDosEvent extends ToDoEvent {
  const SyncToDosEvent();
}