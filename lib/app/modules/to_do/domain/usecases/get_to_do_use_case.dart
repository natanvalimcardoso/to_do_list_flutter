import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/to_do_entity.dart';
import '../repositories/to_do_repository.dart' show ToDoRepository;

class GetToDoUseCase  {
  final ToDoRepository repository;

  GetToDoUseCase(this.repository);

  Future<Either<Failure, List<ToDoEntity>>> call({required int skip, required int limit}) {
    return repository.getTodos(skip: skip, limit: limit);
  }
}
