import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/to_do_entity.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoEntity>>> getTodos({required int skip, required int limit});
}
