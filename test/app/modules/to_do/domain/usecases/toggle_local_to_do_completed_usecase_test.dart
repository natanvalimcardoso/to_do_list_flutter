import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/toggle_local_to_do_completed_usecase.dart';

class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}

void main() {
  late ToggleLocalToDoUsecase usecase;
  late MockToDoLocalRepository repository;

  setUp(() {
    repository = MockToDoLocalRepository();
    usecase = ToggleLocalToDoUsecase(repository);
  });

  final todos = [
    const ToDoEntity(id: 1, todo: 'Teste', completed: false, userId: 0),
  ];

  test('Deve alternar estado corretamente', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => Right([...todos]));
    when(() => repository.saveTodos(any())).thenAnswer((_) async => const Right(unit));

    final result = await usecase(1, true);

    expect(result.isRight(), true);
    verify(() => repository.getTodos()).called(1);
    verify(() => repository.saveTodos(any())).called(1);
  });

  test('Deve retornar falha caso não encontre tarefa', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => const Right([]));

    final result = await usecase(999, true); 

    expect(result.isLeft(), true);
    expect(result.fold((l)=>l, (r)=> r), isA<ToDoNotFoundFailure>());
  });
}