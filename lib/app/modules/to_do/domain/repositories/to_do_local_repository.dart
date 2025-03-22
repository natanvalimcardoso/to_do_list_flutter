import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/to_do_entity.dart';

abstract class ToDoLocalRepository {
  Future<Either<Failure, List<ToDoEntity>>> getLocalTodos();
  Future<Either<Failure, void>> addLocalTodo({required ToDoEntity todo});
  Future<Either<Failure, void>> removeLocalTodo({required int id});
  Future<Either<Failure, void>> toggleLocalTodoCompleted({required int id, required bool completed});
  Future<Either<Failure, void>> addAllLocalTodos({required List<ToDoEntity> todos});
}