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
  Future<void> saveTodos(List<ToDoModel> todos) async {
    final todosEncoded = todos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(SharedPreferencesConstant.localToDo, todosEncoded);
  }
}
