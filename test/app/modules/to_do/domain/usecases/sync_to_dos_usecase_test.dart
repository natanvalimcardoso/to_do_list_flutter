import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_remote_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/sync_to_dos_usecase.dart';

class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}

class MockToDoRemoteRepository extends Mock implements ToDoRemoteRepository {}

void main() {
  late SyncToDosUsecase usecase;
  late MockToDoLocalRepository localRepository;
  late MockToDoRemoteRepository remoteRepository;

  final remoteToDos = [
    const ToDoEntity(id: 1, todo: 'Task 1', completed: false, userId: 1),
    const ToDoEntity(id: 2, todo: 'Task 2', completed: false, userId: 2),
  ];

  final localToDos = [const ToDoEntity(id: 1, todo: 'Task 1', completed: false, userId: 1)];

  setUp(() {
    localRepository = MockToDoLocalRepository();
    remoteRepository = MockToDoRemoteRepository();
    usecase = SyncToDosUsecase(
      localRepository: localRepository,
      remoteRepository: remoteRepository,
    );
  });

  test('deve sincronizar e salvar novas tarefas remotas no repositório local', () async {
    when(() => remoteRepository.getRemoteToDos()).thenAnswer((_) async => Right(remoteToDos));
    when(() => localRepository.getTodos()).thenAnswer((_) async => Right(localToDos));
    when(() => localRepository.saveTodos(any())).thenAnswer((_) async => const Right(unit));

    final result = await usecase();

    expect(result, const Right(unit));
    verify(() => localRepository.saveTodos([...localToDos, remoteToDos[1]])).called(1);
  });

  test('não deve salvar se as tarefas remotas já existem localmente', () async {
    when(() => remoteRepository.getRemoteToDos()).thenAnswer((_) async => Right(localToDos));
    when(() => localRepository.getTodos()).thenAnswer((_) async => Right(localToDos));

    final result = await usecase();

    expect(result, const Right(unit));
    verifyNever(() => localRepository.saveTodos(any()));
  });

  test('deve retornar erro RemoteFailure quando repository remoto falhar', () async {
    when(() => remoteRepository.getRemoteToDos()).thenAnswer((_) async => Left(RemoteFailure()));

    final result = await usecase();

    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => null), isA<RemoteFailure>());
    verifyNever(() => localRepository.getTodos());
    verifyNever(() => localRepository.saveTodos(any()));
  });

  test('deve retornar erro GetTodoListLocalFailure quando repository local falhar', () async {
    when(() => remoteRepository.getRemoteToDos()).thenAnswer((_) async => Right(remoteToDos));
    when(() => localRepository.getTodos()).thenAnswer((_) async => Left(GetTodoListLocalFailure()));

    final result = await usecase();

    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => null), isA<GetTodoListLocalFailure>());
    verifyNever(() => localRepository.saveTodos(any()));
  });

  test(
    'deve retornar erro SaveToDoFailure quando falhar ao salvar as tarefas localmente',
    () async {
      when(() => remoteRepository.getRemoteToDos()).thenAnswer((_) async => Right(remoteToDos));
      when(() => localRepository.getTodos()).thenAnswer((_) async => Right(localToDos));
      when(() => localRepository.saveTodos(any())).thenAnswer((_) async => Left(SaveToDoFailure()));

      final result = await usecase();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<SaveToDoFailure>());
      verify(() => localRepository.saveTodos([...localToDos, remoteToDos[1]])).called(1);
    },
  );
}
