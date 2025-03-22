import 'package:equatable/equatable.dart';

import '../../domain/entities/to_do_entity.dart';

abstract class ToDoState extends Equatable {
  final List<ToDoEntity> todos;
  final bool hasMore;

  const ToDoState({required this.todos, this.hasMore = true});

  @override
  List<Object?> get props => [todos, hasMore];
}

class ToDoInitialState extends ToDoState {
  const ToDoInitialState() : super(todos: const []);
}

class ToDoLoadingState extends ToDoState {
  const ToDoLoadingState({required super.todos});
}

class ToDoLoadedState extends ToDoState {
  const ToDoLoadedState({required super.todos, required super.hasMore});
}

class ToDoErrorState extends ToDoState {
  final String message;

  const ToDoErrorState({required super.todos, required this.message});

  @override
  List<Object?> get props => [todos, message];
}
