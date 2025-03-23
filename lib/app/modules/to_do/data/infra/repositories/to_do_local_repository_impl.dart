import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/to_do_entity.dart';
import '../../../domain/errors/errors_todo.dart';
import '../../../domain/repositories/to_do_local_repository.dart';
import '../datasources/local/to_do_local_datasource.dart';
import '../models/to_do_model.dart';

class ToDoLocalRepositoryImpl implements ToDoLocalRepository {
  final ToDoLocalDatasource datasource;

  ToDoLocalRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ToDoEntity>>> getLocalTodos() async {
    try {
      final todos = await datasource.getTodos();
      return Right(todos);
    } catch (_) {
      return Left(GetTodoListLocalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addLocalTodo({required List<ToDoEntity> todos}) async {
    try {
      final models = todos.map(ToDoModel.fromEntity).toList();
      await datasource.saveTodoLocal(todos: models);
      return const Right(unit);
    } catch (_) {
      return Left(AddToDoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeLocalTodo({required int id}) async {
    try {
      await datasource.deleteTodoLocal(id: id);
      return const Right(unit);
    } catch (_) {
      return Left(DeleteToDoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleLocalTodoCompleted({
    required int id,
    required bool completed,
  }) async {
    try {
      await datasource.updateTodoStatusLocal(id: id, completed: completed);
      return const Right(unit);
    } catch (_) {
      return Left(UpdateToDoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addAllLocalTodos({required List<ToDoEntity> todos}) async {
    try {
      final models = todos.map(ToDoModel.fromEntity).toList();
      await datasource.saveAllTodosLocal(todos: models);
      return const Right(unit);
    } catch (_) {
      return Left(AddToDoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLocalTodo({required ToDoEntity todo}) async {
    try {
      final model = ToDoModel.fromEntity(todo);
      await datasource.updateTodoLocal(todo: model);
      return const Right(unit);
    } catch (_) {
      return Left(UpdateToDoFailure());
    }
  }
}