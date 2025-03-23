import 'package:fpdart/fpdart.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/errors/errors_todo.dart';

import '../entities/to_do_entity.dart';
import '../repositories/to_do_local_repository.dart';
import 'get_local_to_dos_usecase.dart';

class AddLocalToDoUsecase {
  final ToDoLocalRepository repository;
  final GetLocalToDosUsecase getLocalToDosUsecase;

  AddLocalToDoUsecase(this.repository, this.getLocalToDosUsecase);

  Future<Either<Failure, Unit>> call({required ToDoEntity todo}) async {
    final allTodosOrFailure = await getLocalToDosUsecase();

    return allTodosOrFailure.fold(
      (failure) => Left(GetTodoListLocalFailure()),
      (existingTodos) {
        final hasDuplicate = existingTodos.any(
          (t) => t.todo.trim().toLowerCase() == todo.todo.trim().toLowerCase(),
        );

        if (hasDuplicate) {
          return Left(DuplicateToDoFailure());
        }

        final updatedTodos = [todo, ...existingTodos];

        return repository.addLocalTodo(todos: updatedTodos);
      },
    );
  }
}