import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';

abstract class ToDoLocalRepository {
  Future<Either<Failure, List<ToDoEntity>>> getLocalTodos();
  Future<Either<Failure, Unit>> addLocalTodo({required List<ToDoEntity> todos});
  Future<Either<Failure, Unit>> removeLocalTodo({required int id});
  Future<Either<Failure, Unit>> toggleLocalTodoCompleted({required int id, required bool completed});
  Future<Either<Failure, Unit>> addAllLocalTodos({required List<ToDoEntity> todos});
  Future<Either<Failure, Unit>> updateLocalTodo({required ToDoEntity todo});
}