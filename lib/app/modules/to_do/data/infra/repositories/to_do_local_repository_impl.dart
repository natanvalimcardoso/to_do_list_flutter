import 'package:fpdart/fpdart.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../domain/entities/to_do_entity.dart';
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
      return Left(LocalFailure("Erro ao carregar tarefas locais"));
    }
  }

  @override
  Future<Either<Failure, void>> addLocalTodo({required ToDoEntity todo}) async {
    try {
      final model = ToDoModel.fromEntity(todo);
      await datasource.saveTodoLocal(todo: model);
      return const Right(null);
    } catch (_) {
      return Left(LocalFailure("Erro ao salvar tarefa local"));
    }
  }

  @override
  Future<Either<Failure, void>> removeLocalTodo({required int id}) async {
    try {
      await datasource.deleteTodoLocal(id: id);
      return const Right(null);
    } catch (_) {
      return Left(LocalFailure("Erro ao remover tarefa local"));
    }
  }

  @override
  Future<Either<Failure, void>> toggleLocalTodoCompleted({required int id, required bool completed}) async {
    try {
      await datasource.updateTodoStatusLocal(id: id, completed: completed);
      return const Right(null);
    } catch (_) {
      return Left(LocalFailure("Erro ao atualizar tarefa local"));
    }
  }

  // 👇 NOVO método adicionar Vários Todos
  @override
  Future<Either<Failure, void>> addAllLocalTodos({required List<ToDoEntity> todos}) async {
    try {
      final models = todos.map((entity) => ToDoModel.fromEntity(entity)).toList();
      await datasource.saveAllTodosLocal(todos: models);
      return const Right(null);
    } catch (_) {
      return Left(LocalFailure("Erro ao salvar tarefas da API localmente"));
    }
  }
}