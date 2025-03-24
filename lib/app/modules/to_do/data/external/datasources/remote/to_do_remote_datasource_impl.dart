import 'package:dio/dio.dart';
import '../../../../../../../core/network/api_endpoint.dart';
import '../../../infra/datasources/remote/to_do_remote_datasource.dart';
import '../../../infra/models/to_do_model.dart';

class ToDoRemoteDatasourceImpl implements ToDoRemoteDatasource {
  final Dio dio;

  ToDoRemoteDatasourceImpl(this.dio);

  @override
  Future<List<ToDoModel>> fetchTodos() async {
    final response = await dio.get(ApiEndpoint.todos);
    return ToDoModel.fromJsonList(response.data['todos']);
  }

  @override
  Future<ToDoModel> fetchTodoById({required int id}) async {
    final response = await dio.get("${ApiEndpoint.todos}/$id");
    return ToDoModel.fromJson(response.data);
  }
}
