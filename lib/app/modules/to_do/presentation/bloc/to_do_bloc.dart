import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/sync_to_dos_usecase.dart';
import '../../domain/usecases/delete_to_do_usecase.dart';
import '../../domain/usecases/toggle_local_to_do_completed_usecase.dart';
import '../../domain/usecases/update_local_to_do_use_casa.dart';
import '../../domain/entities/to_do_entity.dart';
import '../../domain/errors/errors_todo.dart';
import '../../domain/usecases/add_all_local_to_dos_usecase.dart';
import '../../domain/usecases/add_local_to_do_usecase.dart';
import '../../domain/usecases/get_local_to_dos_usecase.dart';
import 'to_do_event.dart';
import 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final GetLocalToDosUsecase getLocalTodosUseCase;
  final AddLocalToDoUsecase addLocalTodoUseCase;
  final DeleteLocalToDoUsecase deleteLocalTodoUseCase;
  final ToggleLocalToDoUsecase toggleLocalTodoUsecase;
  final UpdateLocalToDoUsecase updateLocalTodoUsecase;
  final AddAllLocalToDosUsecase addAllLocalTodosUsecase;
  final SyncToDosUsecase syncToDosUsecase;

  ToDoBloc({
    required this.getLocalTodosUseCase,
    required this.addLocalTodoUseCase,
    required this.deleteLocalTodoUseCase,
    required this.toggleLocalTodoUsecase,
    required this.updateLocalTodoUsecase,
    required this.addAllLocalTodosUsecase,
    required this.syncToDosUsecase,
  }) : super(const ToDoInitialState()) {
    on<LoadTodosEvent>(_loadTodos);
    on<AddToDoEvent>(_addTodo);
    on<DeleteToDoEvent>(_deleteTodo);
    on<ToggleToDoEvent>(_toggleTodo);
    on<UpdateToDoEvent>(_updateTodo);
    on<AddAllToDosEvent>(_addAllTodos);
    on<SyncToDosEvent>(_syncTodos);
  }

  Future<void> _syncTodos(SyncToDosEvent event, Emitter<ToDoState> emit) async {
    emit(ToDoLoadingState(todos: state.todos));

    final syncResult = await syncToDosUsecase();

    syncResult.fold(
      (failure) => emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos)),
      (_) => add(const LoadTodosEvent()),
    );
  }

  Future<void> _loadTodos(LoadTodosEvent event, Emitter<ToDoState> emit) async {
    emit(ToDoLoadingState(todos: state.todos));

    final result = await getLocalTodosUseCase();

    result.fold((failure) {
      emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos));
    }, (todos) => emit(ToDoLoadedState(todos: todos)));
  }

  Future<void> _addTodo(AddToDoEvent event, Emitter<ToDoState> emit) async {
    emit(ToDoLoadingState(todos: state.todos));

    final newToDo = ToDoEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      todo: event.text,
      completed: false,
      userId: 0,
    );

    final result = await addLocalTodoUseCase(newToDo);

    result.fold((failure) {
      emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos));
    }, (_) => add(const LoadTodosEvent()));
  }

  Future<void> _deleteTodo(DeleteToDoEvent event, Emitter<ToDoState> emit) async {
    final result = await deleteLocalTodoUseCase(event.id);

    result.fold((failure) {
      emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos));
    }, (_) => add(const LoadTodosEvent()));
  }

  Future<void> _toggleTodo(ToggleToDoEvent event, Emitter<ToDoState> emit) async {
    final result = await toggleLocalTodoUsecase(event.id, event.completed);

    result.fold((failure) {
      emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos));
    }, (_) => add(const LoadTodosEvent()));
  }

  Future<void> _updateTodo(UpdateToDoEvent event, Emitter<ToDoState> emit) async {
    final result = await updateLocalTodoUsecase(event.todo);

    result.fold((failure) {
      emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos));
    }, (_) => add(const LoadTodosEvent()));
  }

  Future<void> _addAllTodos(AddAllToDosEvent event, Emitter<ToDoState> emit) async {
    final result = await addAllLocalTodosUsecase(event.todos);

    result.fold((failure) {
      emit(ToDoErrorState(message: mapFailureToMessage(failure), todos: state.todos));
    }, (_) => add(const LoadTodosEvent()));
  }
}
