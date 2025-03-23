import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/update_local_to_do_use_casa.dart';
import '../../domain/entities/to_do_entity.dart';
import '../../domain/usecases/add_all_local_to_dos_usecase.dart';
import '../../domain/usecases/add_local_to_do_usecase.dart';
import '../../domain/usecases/delete_to_do_usecase.dart';
import '../../domain/usecases/get_local_to_dos_usecase.dart';
import '../../domain/usecases/get_remote_to_dos_usecase.dart';
import '../../domain/usecases/toggle_local_to_do_completed_usecase.dart';
import 'to_do_event.dart';
import 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final GetRemoteToDosUsecase getRemoteToDosUsecase;
  final GetLocalToDosUsecase getLocalTodosUseCase;
  final AddLocalToDoUsecase addLocalTodoUseCase;
  final AddAllLocalToDosUsecase addAllLocalTodosUseCase;
  final DeleteLocalToDoUsecase deleteLocalTodoUseCase;
  final ToggleLocalToDoCompletedUsecase toggleLocalTodoCompletedUseCase;
  final UpdateLocalTodoUsecase updateLocalTodoUsecase;
  ToDoEntity? todoBeingEdited;
  bool hasLoadedInitialData = false;

  ToDoBloc({
    required this.getRemoteToDosUsecase,
    required this.getLocalTodosUseCase,
    required this.addLocalTodoUseCase,
    required this.addAllLocalTodosUseCase,
    required this.deleteLocalTodoUseCase,
    required this.toggleLocalTodoCompletedUseCase,
    required this.updateLocalTodoUsecase,
  }) : super(const ToDoInitialState()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddToDoEvent>(_onAddToDo);
    on<ToggleToDoEvent>(_onToggleToDo);
    on<DeleteToDoEvent>(_onDeleteToDo);
    on<UpdateToDoEvent>(_onUpdateToDo);

    on<EditingTodoChangedEvent>(_onEditingTodoChanged);
    on<SaveTodoChangesEvent>(_onSaveTodoChanges);
  }

  Future<void> _onLoadTodos(LoadTodosEvent event, Emitter<ToDoState> emit) async {
    emit(ToDoLoadingState(todos: state.todos));

    // Só carrega API na primeira vez
    if (!hasLoadedInitialData) {
      final apiResult = await getRemoteToDosUsecase(skip: 0, limit: 100);

      await apiResult.fold(
        (failure) async => emit(ToDoErrorState(todos: [], message: failure.message)),
        (todosFromApi) async {
          // Salva todos de uma vez, evitando duplicidade pelos nomes
          await addAllLocalTodosUseCase(todos: todosFromApi);
          hasLoadedInitialData = true;
        },
      );
    }

    // Sempre lê local após isso
    final localResult = await getLocalTodosUseCase();

    localResult.fold(
      (e) => emit(ToDoErrorState(todos: [], message: e.message)),
      (localTodos) => emit(ToDoLoadedState(todos: localTodos)),
    );
  }

  Future<void> _onAddToDo(AddToDoEvent event, Emitter<ToDoState> emit) async {
    final newToDo = ToDoEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      todo: event.todoText,
      completed: false,
      userId: 0,
    );

    // captura a exceção caso o item já exista
    try {
      await addLocalTodoUseCase(todo: newToDo);
      add(LoadTodosEvent());
    } catch (e) {
      emit(ToDoErrorState(message: e.toString().replaceAll('Exception: ', ''), todos: state.todos));
    }
  }

  Future<void> _onToggleToDo(ToggleToDoEvent event, Emitter<ToDoState> emit) async {
    await toggleLocalTodoCompletedUseCase(id: event.id, completed: event.completed);
    add(LoadTodosEvent());
  }

  Future<void> _onDeleteToDo(DeleteToDoEvent event, Emitter<ToDoState> emit) async {
    await deleteLocalTodoUseCase(id: event.id);
    add(LoadTodosEvent());
  }

  Future<void> _onUpdateToDo(UpdateToDoEvent event, Emitter<ToDoState> emit) async {
    await updateLocalTodoUsecase(todo: event.todo);
    add(LoadTodosEvent());
  }

  void _onEditingTodoChanged(EditingTodoChangedEvent event, Emitter<ToDoState> emit) {
    todoBeingEdited = event.todo;
    emit(EditingToDoState(todoBeingEdited: event.todo, todos: state.todos));
  }

  Future<void> _onSaveTodoChanges(SaveTodoChangesEvent event, Emitter<ToDoState> emit) async {
    if (todoBeingEdited != null) {
      await updateLocalTodoUsecase(todo: todoBeingEdited!);
      todoBeingEdited = null; // Limpa após salvar
      add(LoadTodosEvent()); //Recarrega listagem com dados atuais
    }
  }
}
