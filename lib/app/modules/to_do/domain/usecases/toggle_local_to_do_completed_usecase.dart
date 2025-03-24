import 'package:fpdart/fpdart.dart';

import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class ToggleLocalToDoUsecase {
  final ToDoLocalRepository repo;

  ToggleLocalToDoUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id, bool completed) async {
    final result = await repo.getTodos();

    return result.fold(
      (failure) => Left(failure),
      (todos) {
        final index = todos.indexWhere((t) => t.id == id);
        if (index == -1) return Left(ToDoNotFoundFailure());

        todos[index] = todos[index].copyWith(completed: completed);

        return repo.saveTodos(todos);
      },
    );
  }
}