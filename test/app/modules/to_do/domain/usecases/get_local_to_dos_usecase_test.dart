import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/get_local_to_dos_usecase.dart';


class MockToDoLocalRepository extends Mock implements ToDoLocalRepository {}
void main() {
  late GetLocalToDosUsecase usecase;
  late MockToDoLocalRepository repository;

  setUp(() {
    repository = MockToDoLocalRepository();
    usecase = GetLocalToDosUsecase(repository);
  });

  final todos = [const ToDoEntity(id: 1, todo: 'Teste', completed: false, userId: 0)];

  test('Deve obter todos corretamente', () async {
    when(() => repository.getTodos()).thenAnswer((_) async => Right(todos));

    final result = await usecase();

    expect(result.isRight(), true);
    expect(result.fold((l)=>l, (r)=>r), equals(todos));
  });
}