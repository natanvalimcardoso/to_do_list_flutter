import 'package:equatable/equatable.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_entity.dart';

class ToDoDetailsEntity extends Equatable {
  final ToDoEntity todo;

  const ToDoDetailsEntity({required this.todo});

  @override
  List<Object?> get props => [todo];
}
