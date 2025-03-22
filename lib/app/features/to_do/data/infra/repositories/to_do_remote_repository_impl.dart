import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../domain/entities/to_do_entity.dart';
import '../../../domain/repositories/to_do_remote_repository.dart';
import '../datasources/remote/to_do_remote_datasource.dart';

class TodoRemoteRepositoryImpl implements ToDoRemoteRepository {
  final ToDoRemoteDatasource datasource;

  TodoRemoteRepositoryImpl(this.datasource);
  //todo: O texto de tratamento de erro n pode ser aqui
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
        return const Left(NetworkFailure('Verifique a conexão com a internet.'));
      } else {
        return Left(ServerFailure(dioError.message ?? 'Erro inesperado no servidor.'));
      }
    } catch (e) {
      return Left(UnexpectedFailure('Erro inesperado: $e'));
    }
  }
}
