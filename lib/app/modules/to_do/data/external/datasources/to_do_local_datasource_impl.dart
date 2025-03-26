import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/constants/shared_preferences_constant.dart';
import '../../infra/datasources/to_do_local_datasource.dart';
import '../../infra/models/to_do_model.dart';

class ToDoLocalDatasourceImpl implements ToDoLocalDatasource {
  final SharedPreferences prefs;

  ToDoLocalDatasourceImpl(this.prefs);

  @override
  Future<List<ToDoModel>> getTodos() async {
    final toDosString = prefs.getStringList(SharedPreferencesConstant.localToDo) ?? [];
    return toDosString.map((e) => ToDoModel.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> saveTodos(List<ToDoModel> toDos) async {
    final toDosEncoded = toDos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(SharedPreferencesConstant.localToDo, toDosEncoded);
  }
}
