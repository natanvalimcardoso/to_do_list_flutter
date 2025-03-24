import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/add_all_local_to_dos_usecase.dart';

class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}

void main() {
  late AddAllLocalToDosUsecase usecase;
  late MockToDoLocalRepository repository;

  setUp(() {
    repository = MockToDoLocalRepository();
    usecase = AddAllLocalToDosUsecase(repository);
  });

  final newTodos = [const ToDoEntity(id: 2, todo: 'Teste novo', completed: false, userId: 0)];

  test('Deve adicionar corretamente tarefas novas ao repositório', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => Right([]));
    when(() => repository.saveTodos(any())).thenAnswer((_) async => const Right(unit));

    final result = await usecase(newTodos);

    expect(result.isRight(), true);
    verify(() => repository.getTodos()).called(1);
    verify(() => repository.saveTodos(any())).called(1);
  });
}