import '../models/to_do_model.dart';

abstract class ToDoLocalDatasource {
  Future<List<ToDoModel>> getTodos();
  Future<void> saveTodos(List<ToDoModel> todos);
}