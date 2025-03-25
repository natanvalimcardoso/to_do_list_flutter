import 'package:fpdart/fpdart.dart';

import '../errors/errors_todo.dart';
import '../repositories/to_do_local_repository.dart';
import '../repositories/to_do_remote_repository.dart';

class SyncToDosUsecase {
  final ToDoLocalRepository localRepository;
  final ToDoRemoteRepository remoteRepository;

  SyncToDosUsecase({
    required this.localRepository,
    required this.remoteRepository,
  });

  Future<Either<Failure, Unit>> call() async {
    final remoteResult = await remoteRepository.getRemoteToDos();
    if (remoteResult.isLeft()) {
      return Left(RemoteFailure());
    }

    final localResult = await localRepository.getTodos();
    if (localResult.isLeft()) {
      return Left(GetTodoListLocalFailure());
    }

    final remoteToDos = remoteResult.getOrElse((_) => []);
    final localToDos = localResult.getOrElse((_) => []);

    final newToDos = remoteToDos.where((remote) =>
        !localToDos.any((local) => local.todo.trim().toLowerCase() == remote.todo.trim().toLowerCase())).toList();

    if (newToDos.isNotEmpty) {
      final mergedToDos = [...localToDos, ...newToDos];
      final saveResult = await localRepository.saveTodos(mergedToDos);
      if (saveResult.isLeft()) {
        return Left(SaveToDoFailure());
      }
    }

    return const Right(unit);
  }
}