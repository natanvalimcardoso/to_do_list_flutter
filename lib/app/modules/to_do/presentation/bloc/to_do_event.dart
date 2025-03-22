import 'package:equatable/equatable.dart';

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