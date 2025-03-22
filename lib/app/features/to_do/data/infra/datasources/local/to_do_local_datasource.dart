import '../../models/to_do_model.dart';

abstract class ToDoLocalDatasource {
  Future<List<ToDoModel>> getTodos();
  Future<void> saveTodoLocal({required ToDoModel todo});
  Future<void> deleteTodoLocal({required int id});
  Future<void> updateTodoStatusLocal({required int id,required bool completed});
}