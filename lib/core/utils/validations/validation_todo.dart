class ValidationTodo {
  static String? validateToDo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite uma tarefa válida!';
    }
    return null;
  }

  static String? validateToDoDetails(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite uma descrição válida!';
    }
    return null;
  }
}

