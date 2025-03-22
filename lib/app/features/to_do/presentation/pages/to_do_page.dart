import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';
import '../bloc/to_do_state.dart';
import '../widgets/to_do_item_widget.dart';
import '../../../../injections/injection_container.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _scroll = ScrollController();
  late final ToDoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ToDoBloc>()
      ..add(LoadLocalToDoEvent())
      ..add(LoadRemoteToDoEvent());

    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _bloc.close();
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels + 50 >= _scroll.position.maxScrollExtent) {
      _bloc.add(LoadMoreToDoEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoBloc>(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('ToDo')),
        body: BlocBuilder<ToDoBloc, ToDoState>(
          builder: (context, state) {
            if (state is ToDoLoadingState && state.todos.isEmpty && state.localTodos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ToDoErrorState && state.todos.isEmpty && state.localTodos.isEmpty) {
              return Center(child: Text("Erro: ${state.message}"));
            }

            if (state.todos.isEmpty && state.localTodos.isEmpty) {
              return const Center(child: Text("Nenhuma tarefa encontrada."));
            }

            return SingleChildScrollView(
              controller: _scroll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Primeiro: Lista LOCAL
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Tarefas Locais',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (state.localTodos.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Nenhuma tarefa local criada."),
                    ),
                  if (state.localTodos.isNotEmpty)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.localTodos.length,
                      itemBuilder: (context, index) {
                        final localTodo = state.localTodos[index];
                        return ToDoItemWidget(todo: localTodo);
                      },
                    ),

                  const Divider(height: 30),

                  // Segundo: Lista REMOTA
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Tarefas Remotas (API)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.todos.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.todos.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final todo = state.todos[index];
                      return ToDoItemWidget(todo: todo);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialogCreateLocalTodo(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showDialogCreateLocalTodo(BuildContext context) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nova Tarefa Local'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Digite sua tarefa local'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _bloc.add(AddLocalToDoEvent(textController.text));
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}