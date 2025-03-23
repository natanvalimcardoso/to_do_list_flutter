import 'package:fpdart/fpdart.dart';

import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';

class DeleteLocalToDoUsecase {
  final ToDoLocalRepository repository;

  DeleteLocalToDoUsecase(this.repository);

  Future<Either<Failure, void>> call({required int id}) {
    return repository.removeLocalTodo(id: id);
  }
}