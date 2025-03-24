import 'package:fpdart/fpdart.dart';

import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class DeleteLocalToDoUsecase {
  final ToDoLocalRepository repo;

  DeleteLocalToDoUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id) async {
    final result = await repo.getTodos();
    return result.fold(
      (failure) => Left(failure),
      (todos) {
        todos.removeWhere((t) => t.id == id);
        return repo.saveTodos(todos);
      },
    );
  }
}