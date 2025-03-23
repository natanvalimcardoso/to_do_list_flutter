import '../../models/to_do_model.dart';

abstract class ToDoRemoteDatasource {
  Future<List<ToDoModel>> fetchTodos();
  Future<ToDoModel> fetchTodoById({required int id});
}
