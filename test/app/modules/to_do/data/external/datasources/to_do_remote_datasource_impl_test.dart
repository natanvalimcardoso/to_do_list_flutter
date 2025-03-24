import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/external/datasources/to_do_remote_datasource_impl.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/models/to_do_model.dart';
import 'package:to_do_list_flutter/core/network/api_endpoint.dart';

// Classe Mock Dio:
class DioMock extends Mock implements Dio {}

void main() {
  late ToDoRemoteDatasourceImpl datasource;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
    datasource = ToDoRemoteDatasourceImpl(dio);
  });

  final tJsonResponse = {
    'todos': [
      {'id': 1, 'todo': 'Tarefa 1', 'completed': false, 'userId': 0},
      {'id': 2, 'todo': 'Tarefa 2', 'completed': true, 'userId': 0},
    ],
  };

  final tToDoList = [
    ToDoModel(id: 1, todo: 'Tarefa 1', completed: false, userId: 0),
    ToDoModel(id: 2, todo: 'Tarefa 2', completed: true, userId: 0),
  ];

  group('fetchTodos()', () {
    test('Deve retornar uma lista de ToDoModel quando a resposta for bem sucedida', () async {
      // Arrange
      when(() => dio.get(ApiEndpoint.todos)).thenAnswer(
        (_) async => Response(
          data: tJsonResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndpoint.todos),
        ),
      );

      // Act
      final result = await datasource.fetchTodos();

      // Assert
      expect(result, equals(tToDoList));
      verify(() => dio.get(ApiEndpoint.todos)).called(1);
    });

    test('Deve lançar uma exceção quando Dio falhar', () async {
      // Arrange
      when(() => dio.get(ApiEndpoint.todos)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoint.todos),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ApiEndpoint.todos),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      expect(() => datasource.fetchTodos(), throwsA(isA<DioException>()));
      verify(() => dio.get(ApiEndpoint.todos)).called(1);
    });
  });
}
