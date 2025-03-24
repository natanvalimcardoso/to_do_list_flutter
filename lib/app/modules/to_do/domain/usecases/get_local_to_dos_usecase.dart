import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class GetLocalToDosUsecase {
  final ToDoLocalRepository repo;

  GetLocalToDosUsecase(this.repo);

  Future<Either<Failure, List<ToDoEntity>>> call() async {
    return repo.getTodos();
  }
}