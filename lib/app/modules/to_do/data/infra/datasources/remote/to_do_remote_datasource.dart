import '../../models/to_do_model.dart';

abstract class ToDoRemoteDatasource {
  Future<List<ToDoModel>> fetchTodos({required int skip, required int limit});
  Future<ToDoModel> fetchTodoById({required int id});
}
