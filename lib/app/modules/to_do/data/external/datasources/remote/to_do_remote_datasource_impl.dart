import 'package:dio/dio.dart';
import '../../../../../../../core/network/api_endpoint.dart';
import '../../../infra/datasources/remote/to_do_remote_datasource.dart';
import '../../../infra/models/to_do_model.dart';

class ToDoRemoteDatasourceImpl implements ToDoRemoteDatasource {
  final Dio dio;

  ToDoRemoteDatasourceImpl(this.dio);

  @override
  Future<List<ToDoModel>> fetchTodos({int skip = 0, int limit = 30}) async {
    try {
      final response = await dio.get(ApiEndpoint.todos, queryParameters: {
        'skip': skip,
        'limit': limit,
      });

      return ToDoModel.fromJsonList(response.data['todos']);
    } catch (e) {
      throw Exception("Erro ao carregar as Tarefas: ${e.toString()}");
    }
  }

  @override
  Future<ToDoModel> fetchTodoById({required int id}) async {
    try {
      final response = await dio.get("${ApiEndpoint.todos}/$id");
      return ToDoModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Erro ao carregar detalhes da Tarefa: ${e.toString()}");
    }
  }
}