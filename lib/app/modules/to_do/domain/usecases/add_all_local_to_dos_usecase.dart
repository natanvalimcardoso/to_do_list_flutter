import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class AddAllLocalToDosUsecase {
  final ToDoLocalRepository toDoLocalRepository;

  AddAllLocalToDosUsecase(this.toDoLocalRepository);

  Future<Either<Failure, Unit>> call(List<ToDoEntity> newTodos) async {
    final result = await toDoLocalRepository.getTodos();
    return result.fold(
      (failure) => Left(AddAllLocalToDosFailure()),
      (todos) {
        final localTodoSet = todos.map((e) => e.todo.trim().toLowerCase()).toSet();
        final filtered = newTodos
            .where((t) => !localTodoSet.contains(t.todo.trim().toLowerCase()))
            .toList();
            
        todos.insertAll(0, filtered);

        return toDoLocalRepository.saveTodos(todos);
      },
    );
  }
}