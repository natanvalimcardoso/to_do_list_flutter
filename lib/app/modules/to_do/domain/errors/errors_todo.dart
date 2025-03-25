abstract class Failure implements Exception {}

class GetTodoListLocalFailure implements Failure {}

class RemoteFailure implements Failure {}

class UnexpectedFailure implements Failure {}

class DuplicateToDoFailure implements Failure {}

class UpdateToDoFailure implements Failure {}

class DeleteToDoFailure implements Failure {}

class AddToDoFailure implements Failure {}

class SaveToDoFailure implements Failure {}

class ToDoNotFoundFailure implements Failure {}

class AddAllLocalToDosFailure implements Failure {}

class ToggleLocalToDoFailure implements Failure {}

class UpdateLocalToDoFailure implements Failure {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (DuplicateToDoFailure):
      return 'Essa tarefa já existe cadastrada.';
    case const (ToDoNotFoundFailure):
      return 'Essa tarefa não foi encontrada.';
    case const (GetTodoListLocalFailure):
      return 'Erro ao obter as tarefas.';
    case const (SaveToDoFailure):
      return 'Erro ao salvar a tarefa.';
    case const (AddToDoFailure):
      return 'Erro ao adicionar a tarefa.';
    case const (DeleteToDoFailure):
      return 'Erro ao deletar a tarefa.';
    case const (UpdateToDoFailure):
      return 'Erro ao atualizar a tarefa.';
    case const (AddAllLocalToDosFailure):
      return 'Erro ao adicionar as tarefas.';
    case const (ToggleLocalToDoFailure):
      return 'Erro ao alterar o status da tarefa.';
    case const (UpdateLocalToDoFailure):
      return 'Erro ao atualizar a tarefa local.';
    case const (RemoteFailure):
      return 'Erro ao obter as tarefas remotas.';
    case const (UnexpectedFailure):
      return 'Erro inesperado, tente novamente.';
    default:
      return 'Erro inesperado, tente novamente.';
  }
}
