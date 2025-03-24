import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/repositories/to_do_remote_repository.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/get_remote_to_dos_usecase.dart';

class MockToDoRemoteRepository extends Mock implements ToDoRemoteRepository {}

void main() {
  late GetRemoteToDosUsecase usecase;
  late MockToDoRemoteRepository repository;

  setUp(() {
    repository = MockToDoRemoteRepository();
    usecase = GetRemoteToDosUsecase(repository);
  });

  final todos = [const ToDoEntity(id: 1, todo: 'Teste Remote', completed: false, userId: 0)];

  test('Deve obter todos remotos corretamente', () async {
    when(() => repository.getRemoteToDos()).thenAnswer((_) async => Right(todos));

    final result = await usecase();

    expect(result.isRight(), true);
  });
}