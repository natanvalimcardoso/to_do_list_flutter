class ValidationTodo {
  static String? validateToDo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite uma tarefa válida!';
    }
    return null;
  }
}

