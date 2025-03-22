import 'package:equatable/equatable.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class LoadToDoEvent extends ToDoEvent {}

class LoadMoreToDoEvent extends ToDoEvent {}

class ToggleToDoStatusEvent extends ToDoEvent {
  final int id;
  final bool isCompleted;

  const ToggleToDoStatusEvent(this.id, this.isCompleted);

  @override
  List<Object?> get props => [id, isCompleted];
}

class DeleteToDoEvent extends ToDoEvent {
  final int id;

  const DeleteToDoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddLocalToDoEvent extends ToDoEvent {
  final String todoText;

  const AddLocalToDoEvent(this.todoText);

  @override
  List<Object?> get props => [todoText];
}