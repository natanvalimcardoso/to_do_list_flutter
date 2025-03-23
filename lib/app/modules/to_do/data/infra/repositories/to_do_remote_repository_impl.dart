import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/to_do_entity.dart';
import '../../../domain/errors/errors_todo.dart';
import '../../../domain/repositories/to_do_remote_repository.dart';
import '../datasources/remote/to_do_remote_datasource.dart';

class ToDoRemoteRepositoryImpl implements ToDoRemoteRepository {
  final ToDoRemoteDatasource datasource;

  ToDoRemoteRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ToDoEntity>>> getRemoteToDos({
    required int skip,
    required int limit,
  }) async {
    try {
      final result = await datasource.fetchTodos(skip: skip, limit: limit);
      return Right(result);
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionError) {
        return Left(RemoteFailure());
      } else {
        return Left(RemoteFailure());
      }
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
