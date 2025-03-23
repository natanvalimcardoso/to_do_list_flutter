import 'package:equatable/equatable.dart';

import '../../domain/entities/to_do_entity.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends ToDoEvent {}

class ToggleToDoEvent extends ToDoEvent {
  final int id;
  final bool completed;
  const ToggleToDoEvent(this.id, this.completed);

  @override
  List<Object?> get props => [id, completed];
}

class DeleteToDoEvent extends ToDoEvent {
  final int id;
  const DeleteToDoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddToDoEvent extends ToDoEvent {
  final String todoText;
  const AddToDoEvent(this.todoText);

  @override
  List<Object?> get props => [todoText];
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDoEntity todo;
  const UpdateToDoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class EditingTodoChangedEvent extends ToDoEvent {
  final ToDoEntity todo;
  const EditingTodoChangedEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class SaveTodoChangesEvent extends ToDoEvent {
  const SaveTodoChangesEvent();
}