import 'package:to_do_list_flutter/app/modules/to_do/data/infra/models/to_do_model.dart';

abstract class ToDoLocalDatasource {
  Future<List<ToDoModel>> getTodos();
  Future<void> saveTodos(List<ToDoModel> todos);
}