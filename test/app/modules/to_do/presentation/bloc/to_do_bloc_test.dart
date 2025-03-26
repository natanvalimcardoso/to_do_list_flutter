
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/add_all_local_to_dos_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/add_local_to_do_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/delete_to_do_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/get_local_to_dos_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/toggle_local_to_do_completed_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/update_local_to_do_use_casa.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/sync_to_dos_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/bloc/to_do_bloc.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/bloc/to_do_event.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/bloc/to_do_state.dart';

class MockGetLocalToDosUsecase extends Mock implements GetLocalToDosUsecase {}
class MockAddLocalToDoUsecase extends Mock implements AddLocalToDoUsecase {}
class MockDeleteLocalToDoUsecase extends Mock implements DeleteLocalToDoUsecase {}
class MockToggleLocalToDoUsecase extends Mock implements ToggleLocalToDoUsecase {}
class MockUpdateLocalToDoUsecase extends Mock implements UpdateLocalToDoUsecase {}
class MockAddAllLocalToDosUsecase extends Mock implements AddAllLocalToDosUsecase {}
class MockSyncToDosUsecase extends Mock implements SyncToDosUsecase {}

void main() {
  late ToDoBloc bloc;
  late MockGetLocalToDosUsecase getLocalToDos;
  late MockAddLocalToDoUsecase addToDo;
  late MockDeleteLocalToDoUsecase deleteToDo;
  late MockToggleLocalToDoUsecase toggleToDo;
  late MockUpdateLocalToDoUsecase updateToDo;
  late MockAddAllLocalToDosUsecase addAllToDos;
  late MockSyncToDosUsecase syncToDos;

  final todos = [const ToDoEntity(id: 1, todo: 'Test bloc', completed: false, userId: 0)];

  setUp(() {
    getLocalToDos = MockGetLocalToDosUsecase();
    addToDo = MockAddLocalToDoUsecase();
    deleteToDo = MockDeleteLocalToDoUsecase();
    toggleToDo = MockToggleLocalToDoUsecase();
    updateToDo = MockUpdateLocalToDoUsecase();
    addAllToDos = MockAddAllLocalToDosUsecase();
    syncToDos = MockSyncToDosUsecase();

    bloc = ToDoBloc(
      getLocalTodosUseCase: getLocalToDos,
      addLocalTodoUseCase: addToDo,
      deleteLocalTodoUseCase: deleteToDo,
      toggleLocalTodoUsecase: toggleToDo,
      updateLocalTodoUsecase: updateToDo,
      addAllLocalTodosUsecase: addAllToDos,
      syncToDosUsecase: syncToDos,
    );
  });

  blocTest<ToDoBloc, ToDoState>(
    'Deve emitir [Loading, Loaded] na recuperação das tarefas',
    build: () {
      when(() => getLocalToDos()).thenAnswer((_) async => Right(todos));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadTodosEvent()),
    expect: () => [
      const ToDoLoadingState(todos: []),
      ToDoLoadedState(todos: todos),
    ],
  );

  blocTest<ToDoBloc, ToDoState>(
    'Deve emitir [Loading, Error] se carregamento falhar',
    build: () {
      when(() => getLocalToDos()).thenAnswer((_) async => Left(GetTodoListLocalFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadTodosEvent()),
    expect: () => [
      const ToDoLoadingState(todos: []),
      const ToDoErrorState(message: 'Erro ao obter as tarefas.', todos: []),
    ],
  );

  blocTest<ToDoBloc, ToDoState>(
    'Deve emitir [Loading, Loaded] na sincronização inicial das tarefas',
    build: () {
      when(() => syncToDos()).thenAnswer((_) async => const Right(unit));
      when(() => getLocalToDos()).thenAnswer((_) async => Right(todos));
      return bloc;
    },
    act: (bloc) => bloc.add(const SyncToDosEvent()),
    expect: () => [
      const ToDoLoadingState(todos: []),
      ToDoLoadedState(todos: todos)
    ],
  );
}