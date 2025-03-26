import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/update_local_to_do_use_casa.dart';

class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}

void main() {
  late UpdateLocalToDoUsecase usecase;
  late MockToDoLocalRepository repository;

  setUp(() {
    repository = MockToDoLocalRepository();
    usecase = UpdateLocalToDoUsecase(repository);
  });

  final todos = [
    const ToDoEntity(id: 1, todo: 'Tarefa antiga', completed: false, userId: 0),
  ];

  final todoAtualizado = const ToDoEntity(id: 1, todo: 'Tarefa atualizada', completed: true, userId: 0);

  test('Deve atualizar a tarefa corretamente', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => Right([...todos]));
    when(() => repository.saveTodos(any())).thenAnswer((_) async => const Right(unit));

    final result = await usecase(todoAtualizado);

    expect(result.isRight(), true);
    verify(() => repository.saveTodos(any())).called(1);
  });

  test('Deve retornar ToDoNotFoundFailure se a tarefa não existir', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => const Right([]));

    final result = await usecase(todoAtualizado);

    expect(result.isLeft(), true);
    expect(result.fold((l)=>l, (r)=> r), isA<ToDoNotFoundFailure>());
    verifyNever(() => repository.saveTodos(any()));
  });
}