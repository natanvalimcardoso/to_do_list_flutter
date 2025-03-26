import 'package:dio/dio.dart';
import '../../../../../../core/constants/api_endpoint_constant.dart';
import '../../infra/datasources/to_do_remote_datasource.dart';
import '../../infra/models/to_do_model.dart';

class ToDoRemoteDatasourceImpl implements ToDoRemoteDatasource {
  final Dio dio;

  ToDoRemoteDatasourceImpl(this.dio);

  @override
  Future<List<ToDoModel>> fetchTodos() async {
    final response = await dio.get(ApiEndpoint.toDos);
    return ToDoModel.fromJsonList(response.data['todos']);
  }

}
