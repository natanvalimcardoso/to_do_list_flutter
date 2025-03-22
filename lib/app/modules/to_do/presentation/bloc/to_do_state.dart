import 'package:equatable/equatable.dart';
import '../../domain/entities/to_do_entity.dart';

abstract class ToDoState extends Equatable {
  final List<ToDoEntity> todos;
  final List<ToDoEntity> localTodos;
  final bool hasMore;

  const ToDoState({
    required this.todos,
    required this.localTodos,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [todos, localTodos, hasMore];
}

class ToDoInitialState extends ToDoState {
  const ToDoInitialState() : super(todos: const [], localTodos: const []);
}

class ToDoLoadingState extends ToDoState {
  const ToDoLoadingState({
    required super.todos, 
    required super.localTodos
  });
}

class ToDoLoadedState extends ToDoState {
  const ToDoLoadedState({
    required super.todos,
    required super.localTodos,
    required super.hasMore,
  });
}

class ToDoErrorState extends ToDoState {
  final String message;

  const ToDoErrorState({
    required super.todos, 
    required super.localTodos,
    required this.message,
  });

  @override
  List<Object?> get props => [todos, localTodos, message];
}