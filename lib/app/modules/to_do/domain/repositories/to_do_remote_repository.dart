import 'package:fpdart/fpdart.dart';

import '../entities/to_do_entity.dart';
import '../errors/errors_todo.dart';

abstract class ToDoRemoteRepository {
  Future<Either<Failure, List<ToDoEntity>>> getRemoteToDos();
}
