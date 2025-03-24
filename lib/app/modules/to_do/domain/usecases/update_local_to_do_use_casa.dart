import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class UpdateLocalToDoUsecase {
  final ToDoLocalRepository repo;

  UpdateLocalToDoUsecase(this.repo);

  Future<Either<Failure, Unit>> call(ToDoEntity todo) async {
    final result = await repo.getTodos();

    return result.fold(
      (failure) => Left(UpdateLocalToDoFailure()),
      (todos) {
        final index = todos.indexWhere((t) => t.id == todo.id);
        if (index == -1) return Left(ToDoNotFoundFailure());

        todos[index] = todo;

        return repo.saveTodos(todos);
      },
    );
  }
}
