import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/to_do_entity.dart';
import '../../domain/usecases/get_to_do_use_case.dart';
import 'to_do_event.dart';
import 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final GetToDoUseCase getTodosUseCase;

  int _skip = 0;
  final int _limit = 20;

  ToDoBloc(this.getTodosUseCase) : super(const ToDoInitialState()) {
    on<LoadToDoEvent>(_onLoadToDos);
    on<LoadMoreToDoEvent>(_onLoadMoreToDos);
    on<ToggleToDoStatusEvent>(_onToggleToDoStatus);
    on<DeleteToDoEvent>(_onDeleteToDo);
    on<AddLocalToDoEvent>(_onAddLocalToDo);
  }

  Future<void> _onLoadToDos(LoadToDoEvent event, Emitter<ToDoState> emit) async {
    emit(const ToDoLoadingState(todos: []));
    _skip = 0;
    final result = await getTodosUseCase(skip: _skip, limit: _limit);

    result.fold((failure) => emit(ToDoErrorState(todos: const [], message: failure.message)), (
      todosLoaded,
    ) {
      _skip += todosLoaded.length;
      emit(ToDoLoadedState(todos: todosLoaded, hasMore: todosLoaded.length == _limit));
    });
  }

  Future<void> _onLoadMoreToDos(LoadMoreToDoEvent event, Emitter<ToDoState> emit) async {
    if (state is ToDoLoadingState || !state.hasMore) return;

    emit(ToDoLoadingState(todos: state.todos));

    final result = await getTodosUseCase(skip: _skip, limit: _limit);

    result.fold((failure) => emit(ToDoErrorState(todos: state.todos, message: failure.message)), (
      todosLoaded,
    ) {
      _skip += todosLoaded.length;
      final updatedTodos = List.of(state.todos)..addAll(todosLoaded);

      emit(ToDoLoadedState(todos: updatedTodos, hasMore: todosLoaded.length == _limit));
    });
  }

  void _onToggleToDoStatus(ToggleToDoStatusEvent event, Emitter<ToDoState> emit) {
    final updatedTodos =
        state.todos.map((todo) {
          return todo.id == event.id
              ? ToDoEntity(
                id: todo.id,
                todo: todo.todo,
                completed: event.isCompleted,
                userId: todo.userId,
              )
              : todo;
        }).toList();

    emit(ToDoLoadedState(todos: updatedTodos, hasMore: state.hasMore));
  }

  void _onDeleteToDo(DeleteToDoEvent event, Emitter<ToDoState> emit) {
    final updatedTodos = state.todos.where((todo) => todo.id != event.id).toList();
    emit(ToDoLoadedState(todos: updatedTodos, hasMore: state.hasMore));
  }

  void _onAddLocalToDo(AddLocalToDoEvent event, Emitter<ToDoState> emit) {
    final newTodo = ToDoEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      todo: event.todoText,
      completed: false,
      userId: 0,
    );

    emit(ToDoLoadedState(todos: [newTodo, ...state.todos], hasMore: state.hasMore));
  }
}
