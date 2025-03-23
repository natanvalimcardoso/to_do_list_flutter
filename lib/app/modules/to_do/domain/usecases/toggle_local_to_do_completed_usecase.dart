import 'package:fpdart/fpdart.dart';

import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class ToggleLocalToDoCompletedUsecase {
  final ToDoLocalRepository repository;

  ToggleLocalToDoCompletedUsecase(this.repository);

  Future<Either<Failure, void>> call({required int id, required bool completed}) {
    return repository.toggleLocalTodoCompleted(id: id, completed: completed);
  }
}