import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/to_do_entity.dart';

abstract class ToDoRemoteRepository {
  Future<Either<Failure, List<ToDoEntity>>> getRemoteToDos({required int skip, required int limit});
}
