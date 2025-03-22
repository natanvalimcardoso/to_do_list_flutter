import 'package:equatable/equatable.dart';
//TODO: ARRUMAR O QUE É LOCAL O QUE REMOTO
abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class LoadRemoteToDoEvent extends ToDoEvent {}

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

class LoadLocalToDoEvent extends ToDoEvent {}

class ToggleLocalToDoEvent extends ToDoEvent {
  final int id;
  final bool completed;

  const ToggleLocalToDoEvent(this.id, this.completed);

  @override
  List<Object?> get props => [id, completed];
}

class DeleteLocalToDoEvent extends ToDoEvent {
  final int id;

  const DeleteLocalToDoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
