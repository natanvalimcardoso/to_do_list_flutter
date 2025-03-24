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

