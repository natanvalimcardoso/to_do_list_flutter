import 'package:fpdart/fpdart.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_remote_repository.dart';

import '../entities/to_do_entity.dart';

class GetRemoteToDosUsecase  {
  final ToDoRemoteRepository repository;

  GetRemoteToDosUsecase(this.repository);

  Future<Either<Failure, List<ToDoEntity>>> call({required int skip, required int limit}) {
    return repository.getRemoteToDos(skip: skip, limit: limit);
  }
}
