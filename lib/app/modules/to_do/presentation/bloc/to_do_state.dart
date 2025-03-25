import 'package:equatable/equatable.dart';

import '../../domain/entities/to_do_entity.dart';

abstract class ToDoState extends Equatable {
  final List<ToDoEntity> todos;
  const ToDoState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class ToDoInitialState extends ToDoState {
  const ToDoInitialState() : super(todos: const []);
}

class ToDoLoadingState extends ToDoState {
  const ToDoLoadingState({required super.todos});
}

class ToDoLoadedState extends ToDoState {
  const ToDoLoadedState({required super.todos});
}

class ToDoErrorState extends ToDoState {
  final String message;
  const ToDoErrorState({required this.message, required super.todos});

  @override
  List<Object?> get props => [message, todos];
}