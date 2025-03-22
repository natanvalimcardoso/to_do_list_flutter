import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../core/constants/shared_preferences_constant.dart';
import '../../../infra/datasources/local/to_do_local_datasource.dart';
import '../../../infra/models/to_do_model.dart';

class ToDoLocalDatasourceImpl implements ToDoLocalDatasource {
  final SharedPreferences prefs;

  ToDoLocalDatasourceImpl(this.prefs);

  @override
  Future<List<ToDoModel>> getTodos() async {
    final todosString = prefs.getStringList(SharedPreferencesConstant.localToDo) ?? [];
    return todosString.map((e) => ToDoModel.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> saveTodoLocal({required ToDoModel todo}) async {
    final todos = await getTodos();
    todos.add(todo);
    final todosEncoded = todos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(SharedPreferencesConstant.localToDo, todosEncoded);
  }

  @override
  Future<void> deleteTodoLocal({required int id}) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    final todosEncoded = todos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(SharedPreferencesConstant.localToDo, todosEncoded);
  }

  @override
  Future<void> updateTodoStatusLocal({required int id, required bool completed}) async {
    final todos = await getTodos();
    final todoIndex = todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      todos[todoIndex] = ToDoModel(
        id: todos[todoIndex].id,
        todo: todos[todoIndex].todo,
        completed: completed,
        userId: todos[todoIndex].userId,
      );

      final todosEncoded = todos.map((t) => jsonEncode(t.toJson())).toList();
      await prefs.setStringList(SharedPreferencesConstant.localToDo, todosEncoded);
    }
  }
}
