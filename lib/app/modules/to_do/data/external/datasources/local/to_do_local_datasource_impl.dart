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

    final hasDuplicate = todos.any(
      (t) => t.todo.trim().toLowerCase() == todo.todo.trim().toLowerCase(),
    );

    if (hasDuplicate) {
      throw Exception("Tarefa já existe na lista!");
    }

    todos.insert(0, todo);

    final todosEncoded = todos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(SharedPreferencesConstant.localToDo, todosEncoded);
  }

  @override
  Future<void> deleteTodoLocal({required int id}) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await _saveListInPrefs(todos);
  }

  @override
  Future<void> updateTodoStatusLocal({required int id, required bool completed}) async {
    final todos = await getTodos();
    final todoIndex = todos.indexWhere((todo) => todo.id == id);
    if (todoIndex == -1) return;

    final todoUpdate = ToDoModel(
      id: todos[todoIndex].id,
      todo: todos[todoIndex].todo,
      completed: completed,
      userId: todos[todoIndex].userId,
    );

    todos.removeAt(todoIndex);
    todos.insert(0, todoUpdate); // no topo 👈

    await _saveListInPrefs(todos);
  }

  // 🔥 helper privado reutilizável
  Future<void> _saveListInPrefs(List<ToDoModel> todos) async {
    final todosEncoded = todos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(SharedPreferencesConstant.localToDo, todosEncoded);
  }

  @override
  Future<void> saveAllTodosLocal({required List<ToDoModel> todos}) async {
    final localTodos = await getTodos();

    final localTodoNamesSet = localTodos.map((e) => e.todo.trim().toLowerCase()).toSet();

    final filteredTodos =
        todos.where((todoApi) {
          return !localTodoNamesSet.contains(todoApi.todo.trim().toLowerCase());
        }).toList();

    // Insere tarefas novas no topo
    localTodos.insertAll(0, filteredTodos);

    await _saveListInPrefs(localTodos);
  }

  @override
  Future<void> updateTodoLocal({required ToDoModel todo}) async {
    final todos = await getTodos();
    final index = todos.indexWhere((e) => e.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await _saveListInPrefs(todos);
    }
  }
}
