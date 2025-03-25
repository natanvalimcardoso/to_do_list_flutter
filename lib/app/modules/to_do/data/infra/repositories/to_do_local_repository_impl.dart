import 'package:fpdart/fpdart.dart';
import '../datasources/to_do_local_datasource.dart' show ToDoLocalDatasource;
import '../models/to_do_model.dart';
import '../../../domain/entities/to_do_entity.dart';
import '../../../domain/errors/errors_todo.dart';
import '../../../domain/repositories/to_do_local_repository.dart' show ToDoLocalRepository;

class ToDoLocalRepositoryImpl implements ToDoLocalRepository {
  final ToDoLocalDatasource datasource;

  ToDoLocalRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ToDoEntity>>> getTodos() async {
    try {
      final modelos = await datasource.getTodos();
      final entidades = modelos.map((model) => model.toEntity()).toList();
      return Right(entidades); 
    } catch (_) {
      return Left(GetTodoListLocalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveTodos(List<ToDoEntity> todos) async {
    try {
      final modelos = todos.map(ToDoModel.fromEntity).toList(); 
      await datasource.saveTodos(modelos);
      return const Right(unit);
    } catch (_) {
      return Left(SaveToDoFailure());
    }
  }
}