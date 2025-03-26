import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/delete_to_do_usecase.dart';

class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}
void main() {
  late DeleteLocalToDoUsecase usecase;
  late MockToDoLocalRepository repository;

  setUp(() {
    repository = MockToDoLocalRepository();
    usecase = DeleteLocalToDoUsecase(repository);
  });

   final todosList = [ const ToDoEntity(id: 1, todo: 'Tarefa', completed: false, userId: 0)];
  
  test('Deve deletar tarefa corretamente', () async {
    when(() => repository.getTodos()).thenAnswer((_) async =>  Right(todosList));
    when(() => repository.saveTodos(any())).thenAnswer((_) async => const Right(unit));

    final result = await usecase(1);

    expect(result.isRight(), true);
    verify(() => repository.saveTodos(any())).called(1);
  });
}