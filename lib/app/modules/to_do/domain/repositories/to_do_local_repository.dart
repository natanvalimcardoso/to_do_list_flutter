import 'package:fpdart/fpdart.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';

import '../../../../../core/errors/failure.dart';

abstract class ToDoLocalRepository {
  Future<Either<Failure, List<ToDoEntity>>> getLocalTodos();
  Future<Either<Failure, void>> addLocalTodo({required ToDoEntity todo});
  Future<Either<Failure, void>> removeLocalTodo({required int id});
  Future<Either<Failure, void>> toggleLocalTodoCompleted({required int id, required bool completed});
}
