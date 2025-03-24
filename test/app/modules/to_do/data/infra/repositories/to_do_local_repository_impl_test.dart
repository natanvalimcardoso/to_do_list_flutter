import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/datasources/to_do_local_datasource.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/models/to_do_model.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/repositories/to_do_local_repository_impl.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';

class ToDoLocalDatasourceMock extends Mock implements ToDoLocalDatasource {}

void main() {
  late ToDoLocalRepositoryImpl repository;
  late ToDoLocalDatasourceMock datasource;

  setUp(() {
    datasource = ToDoLocalDatasourceMock();
    repository = ToDoLocalRepositoryImpl(datasource);
  });

  final tToDoModelList = [
     ToDoModel(id: 1, todo: "Teste", completed: false, userId: 0),
     ToDoModel(id: 2, todo: "Outro Teste", completed: true, userId: 0),
  ];

  final tToDoEntityList =
      tToDoModelList.map((model) => model.toEntity()).toList();

  group('getTodos()', () {
    test('Deve retornar uma lista de ToDoEntity com sucesso', () async {
      when(() => datasource.getTodos())
          .thenAnswer((_) async => tToDoModelList);

      final result = await repository.getTodos();

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), equals(tToDoEntityList));
      verify(() => datasource.getTodos()).called(1);
    });

    test('Deve retornar um Failure ao falhar', () async {
      when(() => datasource.getTodos()).thenThrow(Exception());

      final result = await repository.getTodos();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<GetTodoListLocalFailure>());
      verify(() => datasource.getTodos()).called(1);
    });
  });

  group('saveTodos()', () {
    test('Deve salvar os todos com sucesso', () async {
      when(() => datasource.saveTodos(any())).thenAnswer((_) async {});

      final result = await repository.saveTodos(tToDoEntityList);

      expect(result.isRight(), true);
      verify(() => datasource.saveTodos(any())).called(1);
    });

    test('Deve retornar um Failure ao falhar ao salvar', () async {
      when(() => datasource.saveTodos(any())).thenThrow(Exception());

      final result = await repository.saveTodos(tToDoEntityList);

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<SaveToDoFailure>());
      verify(() => datasource.saveTodos(any())).called(1);
    });
  });
}