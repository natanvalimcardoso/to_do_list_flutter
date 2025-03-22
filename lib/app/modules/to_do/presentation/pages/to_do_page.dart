import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injections/injection_container.dart';
import '../../domain/entities/to_do_entity.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';
import '../bloc/to_do_state.dart';
import '../widgets/to_do_item_widget.dart';
import '../widgets/section_title_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  late final ToDoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ToDoBloc>()..add(LoadTodosEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _toggleToDo(ToDoEntity todo, bool completed) {
    _bloc.add(ToggleToDoEvent(todo.id, completed));
  }

  void _deleteToDo(ToDoEntity todo) {
    _bloc.add(DeleteToDoEvent(todo.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoBloc>(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('ToDo')),
        body: BlocBuilder<ToDoBloc, ToDoState>(
          builder: (context, state) {
            if (state is ToDoLoadingState && state.todos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ToDoErrorState && state.todos.isEmpty) {
              return Center(child: Text("Erro: ${state.message}"));
            }

            if (state.todos.isEmpty) {
              return const Center(child: Text("Nenhuma tarefa encontrada."));
            }

            final todosAbertos = state.todos.where((e) => !e.completed).toList();
            final todosConcluidos = state.todos.where((e) => e.completed).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SectionTitleWidget(title: '🟢 Tarefas Abertas'),

                  if (todosAbertos.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Nenhuma tarefa aberta."),
                    )
                  else
                    ...todosAbertos.map((todo) => ToDoItemWidget(
                          todo: todo,
                          onTap: () {},
                          onDelete: () => _deleteToDo(todo),
                          onChanged: (completed) => _toggleToDo(todo, completed!),
                        )),

                  const Divider(height: 30),

                  const SectionTitleWidget(title: '✅ Tarefas Finalizadas'),

                  if (todosConcluidos.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Nenhuma tarefa finalizada."),
                    )
                  else
                    ...todosConcluidos.map((todo) => ToDoItemWidget(
                          todo: todo,
                          onTap: () {},
                          onDelete: () => _deleteToDo(todo),
                          onChanged: (completed) => _toggleToDo(todo, completed!),
                        )),

                  const SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialogCreateTodo(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showDialogCreateTodo(BuildContext context) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nova Tarefa'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Digite sua tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _bloc.add(AddToDoEvent(textController.text));
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}