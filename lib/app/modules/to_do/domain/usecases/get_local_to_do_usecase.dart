import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/to_do_entity.dart';
import '../repositories/to_do_local_repository.dart';

class GetLocalToDosUsecase {
  final ToDoLocalRepository repository;

  GetLocalToDosUsecase(this.repository);

  Future<Either<Failure, List<ToDoEntity>>> call() {
    return repository.getLocalTodos();
  }
}