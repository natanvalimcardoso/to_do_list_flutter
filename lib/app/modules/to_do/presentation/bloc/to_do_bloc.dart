import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/to_do_entity.dart' show ToDoEntity;
import '../../domain/usecases/add_local_to_do_usecase.dart';
import '../../domain/usecases/delete_to_do_usecase.dart';
import '../../domain/usecases/get_local_to_do_usecase.dart';
import '../../domain/usecases/get_remote_to_do_usecase.dart';
import '../../domain/usecases/toggle_local_to_do_completed_usecase.dart';
import 'to_do_event.dart';
import 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
   final GetRemoteToDosUsecase getRemoteToDosUsecase;
  final GetLocalToDosUsecase getLocalTodosUseCase;
  final AddLocalToDoUsecase addLocalTodoUseCase;
  final DeleteLocalToDoUsecase deleteLocalTodoUseCase;
  final ToggleLocalToDoCompletedUsecase toggleLocalTodoCompletedUseCase;

  int _skip = 0;
  final int _limit = 20;

  ToDoBloc({
    required this.getRemoteToDosUsecase,
    required this.getLocalTodosUseCase,
    required this.addLocalTodoUseCase,
    required this.deleteLocalTodoUseCase,
    required this.toggleLocalTodoCompletedUseCase,
  }) : super(const ToDoInitialState()) {
    on<LoadRemoteToDoEvent>(_onLoadToDos);
    on<LoadMoreToDoEvent>(_onLoadMoreToDos);
    on<ToggleToDoStatusEvent>(_onToggleToDoStatus);
    on<DeleteToDoEvent>(_onDeleteToDo);
    on<AddLocalToDoEvent>(_onAddLocalToDo);
    on<LoadLocalToDoEvent>(_onLoadLocalToDos);
    on<ToggleLocalToDoEvent>(_onToggleLocalToDo);
    on<DeleteLocalToDoEvent>(_onDeleteLocalToDo);
  }
  Future<void> _onLoadToDos(LoadRemoteToDoEvent event, Emitter<ToDoState> emit) async {
    emit(const ToDoLoadingState(todos: [], localTodos: []));
    _skip = 0;

    final apiResult = await getRemoteToDosUsecase(skip: _skip, limit: _limit);
    final localResult = await getLocalTodosUseCase();

    apiResult.fold(
      (failure) => emit(ToDoErrorState(todos: const [], localTodos: const [], message: failure.message)),
      (todosLoaded) {
        _skip += todosLoaded.length;
        localResult.fold(
          (failure) => emit(ToDoErrorState(todos: todosLoaded, localTodos: const [], message: failure.message)),
          (localLoaded) => emit(ToDoLoadedState(todos: todosLoaded, localTodos: localLoaded, hasMore: todosLoaded.length == _limit)),
        );
      },
    );
  }

  Future<void> _onLoadMoreToDos(LoadMoreToDoEvent event, Emitter<ToDoState> emit) async {
    if (state is ToDoLoadingState || !state.hasMore) return;

    emit(ToDoLoadingState(todos: state.todos, localTodos: state.localTodos));

    final result = await getRemoteToDosUsecase(skip: _skip, limit: _limit);

    result.fold(
      (failure) => emit(ToDoErrorState(todos: state.todos, localTodos: state.localTodos, message: failure.message)),
      (todosLoaded) {
        _skip += todosLoaded.length;
        final updatedTodos = List.of(state.todos)..addAll(todosLoaded);

        emit(ToDoLoadedState(todos: updatedTodos, localTodos: state.localTodos, hasMore: todosLoaded.length == _limit));
      },
    );
  }

  void _onToggleToDoStatus(ToggleToDoStatusEvent event, Emitter<ToDoState> emit) {
    final updatedTodos = state.todos.map((todo) {
      return todo.id == event.id ? todo.copyWith(completed: event.isCompleted) : todo;
    }).toList();

    emit(ToDoLoadedState(todos: updatedTodos, localTodos: state.localTodos, hasMore: state.hasMore));
  }

  void _onDeleteToDo(DeleteToDoEvent event, Emitter<ToDoState> emit) {
    final updatedTodos = state.todos.where((todo) => todo.id != event.id).toList();
    emit(ToDoLoadedState(todos: updatedTodos, localTodos: state.localTodos, hasMore: state.hasMore));
  }

  Future<void> _onAddLocalToDo(AddLocalToDoEvent event, Emitter<ToDoState> emit) async {
    final newTodo = ToDoEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      todo: event.todoText,
      completed: false,
      userId: 0,
    );

    await addLocalTodoUseCase(todo: newTodo);

    final updatedLocalTodos = [newTodo, ...state.localTodos];
    
    emit(ToDoLoadedState(todos: state.todos, localTodos: updatedLocalTodos, hasMore: state.hasMore));
  }

  Future<void> _onLoadLocalToDos(LoadLocalToDoEvent event, Emitter<ToDoState> emit) async {
    final localResult = await getLocalTodosUseCase();

    localResult.fold(
      (failure) => emit(ToDoErrorState(todos: state.todos, localTodos: const [], message: failure.message)),
      (localLoaded) => emit(ToDoLoadedState(todos: state.todos, localTodos: localLoaded, hasMore: state.hasMore)),
    );
  }

  Future<void> _onToggleLocalToDo(ToggleLocalToDoEvent event, Emitter<ToDoState> emit) async {
    await toggleLocalTodoCompletedUseCase(id: event.id, completed: event.completed);
    add(LoadLocalToDoEvent());
  }

  Future<void> _onDeleteLocalToDo(DeleteLocalToDoEvent event, Emitter<ToDoState> emit) async {
    await deleteLocalTodoUseCase(id: event.id);
    add(LoadLocalToDoEvent());
  }
}