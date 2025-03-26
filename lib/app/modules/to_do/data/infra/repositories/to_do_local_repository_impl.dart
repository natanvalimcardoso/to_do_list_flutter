import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/to_do_entity.dart';
import '../../../domain/errors/errors_todo.dart';
import '../../../domain/repositories/to_do_local_repository.dart';
import '../datasources/to_do_local_datasource.dart';
import '../models/to_do_model.dart';

class ToDoLocalRepositoryImpl implements ToDoLocalRepository {
  final ToDoLocalDatasource datasource;

  ToDoLocalRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ToDoEntity>>> getTodos() async {
    try {
      final toDosModel = await datasource.getTodos();
      final toDoEntities = toDosModel.map((model) => model.toEntity()).toList();
      return Right(toDoEntities); 
    } catch (_) {
      return Left(GetTodoListLocalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveTodos(List<ToDoEntity> toDos) async {
    try {
      final toDosModel = toDos.map(ToDoModel.fromEntity).toList(); 
      await datasource.saveTodos(toDosModel);
      return const Right(unit);
    } catch (_) {
      return Left(SaveToDoFailure());
    }
  }
}