import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class AddAllLocalToDosUsecase {
  final ToDoLocalRepository repository;

  AddAllLocalToDosUsecase(this.repository);

  Future<Either<Failure, void>> call({required List<ToDoEntity> todos}) {
    return repository.addAllLocalTodos(todos: todos);
  }
}