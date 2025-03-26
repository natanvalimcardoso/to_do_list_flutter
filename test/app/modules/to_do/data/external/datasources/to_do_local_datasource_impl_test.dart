import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/external/datasources/to_do_local_datasource_impl.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/models/to_do_model.dart';
import 'package:to_do_list_flutter/core/constants/shared_preferences_constant.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ToDoLocalDatasourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = ToDoLocalDatasourceImpl(mockSharedPreferences);
  });

  const key = SharedPreferencesConstant.localToDo;

  final tToDoModelList = [
    const ToDoModel(id: 1, todo: 'Teste 1', completed: true, userId: 0),
    const ToDoModel(id: 2, todo: 'Teste 2', completed: false, userId: 0),
  ];

  group('getTodos()', () {
    test('Deve retornar lista de Todos corretamente', () async {
      // Arrange
      final encodedList = tToDoModelList.map((e) => jsonEncode(e.toJson())).toList();
      when(() => mockSharedPreferences.getStringList(key)).thenReturn(encodedList);

      // Act
      final result = await datasource.getTodos();

      // Assert
      expect(result, equals(tToDoModelList));
      verify(() => mockSharedPreferences.getStringList(key)).called(1);
    });

    test('Deve retornar lista vazia caso não exista dados salvos', () async {
      // Arrange
      when(() => mockSharedPreferences.getStringList(key)).thenReturn(null);

      // Act
      final result = await datasource.getTodos();

      // Assert
      expect(result, equals([]));
      verify(() => mockSharedPreferences.getStringList(key)).called(1);
    });
  });

  group('saveTodos()', () {
    test('Deve salvar lista de Todos corretamente', () async {
      // Arrange
      final encodedList = tToDoModelList.map((e) => jsonEncode(e.toJson())).toList();
      when(
        () => mockSharedPreferences.setStringList(key, encodedList),
      ).thenAnswer((_) async => true);

      // Act
      await datasource.saveTodos(tToDoModelList);

      // Assert
      verify(() => mockSharedPreferences.setStringList(key, encodedList)).called(1);
    });

    test('Deve lançar exceção caso falhe ao salvar', () async {
      // Arrange
      final encodedList = tToDoModelList.map((e) => jsonEncode(e.toJson())).toList();
      when(() => mockSharedPreferences.setStringList(key, encodedList)).thenThrow(Exception());

      // Act & Assert
      expect(() => datasource.saveTodos(tToDoModelList), throwsA(isA<Exception>()));
      verify(() => mockSharedPreferences.setStringList(key, encodedList)).called(1);
    });
  });
}
