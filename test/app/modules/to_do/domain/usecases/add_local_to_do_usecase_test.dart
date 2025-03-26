// imports mesmos acima (só mudança da classe do Usecase)
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/add_local_to_do_usecase.dart';

class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}

void main() {
  late AddLocalToDoUsecase usecase;
  late MockToDoLocalRepository repository;

  setUp(() {
    repository = MockToDoLocalRepository();
    usecase = AddLocalToDoUsecase(repository);
  });

  final todoNovo = const ToDoEntity(id: 1, todo: 'Nova tarefa', completed: false, userId: 0);

  test('Adicionar com sucesso quando não houver duplicidade', () async {
    when(() => repository.getTodos()).thenAnswer((_) async =>  Right([]));
    when(() => repository.saveTodos(any())).thenAnswer((_) async => const Right(unit));

    final result = await usecase(todoNovo);

    expect(result.isRight(), true);
    verify(() => repository.saveTodos(any())).called(1);
  });

  test('Deve retornar DuplicateToDoFailure se já existir tarefa', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => Right([todoNovo]));

    final result = await usecase(todoNovo);

    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => null), isA<DuplicateToDoFailure>());
  });
}