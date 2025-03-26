import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/datasources/to_do_remote_datasource.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/models/to_do_model.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/repositories/to_do_remote_repository_impl.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';

// Cria mock do datasource
class ToDoRemoteDatasourceMock extends Mock implements ToDoRemoteDatasource {}

void main() {
  late ToDoRemoteRepositoryImpl repository;
  late ToDoRemoteDatasourceMock datasource;

  setUp(() {
    datasource = ToDoRemoteDatasourceMock();
    repository = ToDoRemoteRepositoryImpl(datasource);
  });

  final tToDoModelList = [
     const ToDoModel(id: 1, todo: "Testar app", completed: false, userId: 0),
     const ToDoModel(id: 2, todo: "Corrigir bugs", completed: true, userId: 0),
  ];

  final List<ToDoEntity> tToDoEntityList = tToDoModelList;

  group('getRemoteToDos()', () {
    test('Deve retornar lista de ToDoEntity com sucesso', () async {
      // Arrange
      when(() => datasource.fetchTodos())
          .thenAnswer((_) async => tToDoModelList);

      // Act
      final result = await repository.getRemoteToDos();

      // Assert
      expect(result, equals(Right(tToDoEntityList)));
      verify(() => datasource.fetchTodos()).called(1);
    });

    test('Deve retornar RemoteFailure quando der erro de conexão no Dio', () async {
      //Arrange
      when(() => datasource.fetchTodos()).thenThrow(DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
      ));

      // Act
      final result = await repository.getRemoteToDos();

      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<RemoteFailure>());
      verify(() => datasource.fetchTodos()).called(1);
    });

    test('Deve retornar UnexpectedFailure quando ocorrer outro erro no Dio', () async {
      // Arrange
      when(() => datasource.fetchTodos()).thenThrow(DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.badResponse,
      ));

      // Act
      final result = await repository.getRemoteToDos();

      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<UnexpectedFailure>());
      verify(() => datasource.fetchTodos()).called(1);
    });

    test('Deve retornar UnexpectedFailure quando ocorrer qualquer outra exceção', () async {
      // Arrange
      when(() => datasource.fetchTodos()).thenThrow(Exception('Erro estranho'));

      // Act
      final result = await repository.getRemoteToDos();

      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<UnexpectedFailure>());
      verify(() => datasource.fetchTodos()).called(1);
    });
  });
}