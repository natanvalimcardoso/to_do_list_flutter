import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../domain/entities/to_do_entity.dart';
import '../../../domain/repositories/to_do_repository.dart';
import '../datasources/remote/to_do_remote_datasource.dart';

class TodoRepositoryImpl implements ToDoRepository {
  final ToDoRemoteDatasource datasource;

  TodoRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ToDoEntity>>> getTodos({
    required int skip,
    required int limit,
  }) async {
    try {
      final result = await datasource.fetchTodos(skip: skip, limit: limit);
      return Right(result);
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionError) {
        return const Left(NetworkFailure('Verifique a conexão com a internet.'));
      } else {
        return Left(ServerFailure(dioError.message ?? 'Erro inesperado no servidor.'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Erro inesperado: $e'));
    }
  }
}
