import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/to_do_entity.dart';
import '../repositories/to_do_local_repository.dart';

class UpdateLocalTodoUsecase {
  final ToDoLocalRepository repository;

  UpdateLocalTodoUsecase(this.repository);

  Future<Either<Failure, void>> call({required ToDoEntity todo}) {
    return repository.updateLocalTodo(todo: todo);
  }
}
