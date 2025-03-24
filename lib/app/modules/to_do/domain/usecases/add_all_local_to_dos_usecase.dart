import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

//USECASE PARA ADD VARIAS TAREFAS
class AddAllLocalToDosUsecase {
  final ToDoLocalRepository repo;

  AddAllLocalToDosUsecase(this.repo);

  Future<Either<Failure, Unit>> call(List<ToDoEntity> newTodos) async {
    final result = await repo.getTodos();
    return result.fold(
      (failure) => Left(failure),
      (todos) {
        final localTodoSet = todos.map((e) => e.todo.trim().toLowerCase()).toSet();
        final filtered = newTodos
            .where((t) => !localTodoSet.contains(t.todo.trim().toLowerCase()))
            .toList();
            
        todos.insertAll(0, filtered);

        return repo.saveTodos(todos);
      },
    );
  }
}