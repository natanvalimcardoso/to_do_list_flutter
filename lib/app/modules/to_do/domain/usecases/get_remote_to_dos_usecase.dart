import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_remote_repository.dart';

class GetRemoteToDosUsecase  {
  final ToDoRemoteRepository repository;

  GetRemoteToDosUsecase(this.repository);

  Future<Either<Failure, List<ToDoEntity>>> call() {
    return repository.getRemoteToDos();
  }
}
