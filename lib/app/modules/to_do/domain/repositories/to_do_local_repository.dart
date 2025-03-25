import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';

abstract class ToDoLocalRepository {
  Future<Either<Failure, List<ToDoEntity>>> getTodos();
  Future<Either<Failure, Unit>> saveTodos(List<ToDoEntity> todos);
}  