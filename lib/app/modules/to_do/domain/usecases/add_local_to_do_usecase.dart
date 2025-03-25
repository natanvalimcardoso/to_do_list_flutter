import 'package:fpdart/fpdart.dart';
import '../errors/errors_todo.dart';

import '../entities/to_do_entity.dart';
import '../repositories/to_do_local_repository.dart';
class AddLocalToDoUsecase {
  final ToDoLocalRepository repo;

  AddLocalToDoUsecase(this.repo);

  Future<Either<Failure, Unit>> call(ToDoEntity newTodo) async {
    final result = await repo.getTodos();

    return result.fold(
      (failure) => Left(GetTodoListLocalFailure()),
      (todos) async {
        final exists = todos.any(
          (t) => t.todo.trim().toLowerCase() == newTodo.todo.trim().toLowerCase(),
        );
        if (exists) return Left(DuplicateToDoFailure());

        todos.insert(0, newTodo);
        return repo.saveTodos(todos);
      },
    );
  }
}