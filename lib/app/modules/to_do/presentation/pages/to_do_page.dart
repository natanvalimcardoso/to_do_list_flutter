import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/entities/to_do_details_entity.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/widgets/add_to_do_widget.dart';
import 'package:to_do_list_flutter/core/constants/routes_constant.dart';
import '../../../../injections/injection_container.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';
import '../bloc/to_do_state.dart';
import '../widgets/section_title_widget.dart';
import '../widgets/to_do_item_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final ToDoBloc _bloc = getIt<ToDoBloc>()..add(const LoadTodosEvent());
  final TextEditingController _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _addTodo() {
    final text = _todoController.text.trim();
    if (text.isNotEmpty) {
      _bloc.add(AddToDoEvent(text));
      _todoController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
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

            final todosAbertos = state.todos.where((e) => !e.completed).toList();
            final todosConcluidos = state.todos.where((e) => e.completed).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddToDoWidget(
                    controller: _todoController,
                    onAdd: _addTodo,
                    label: 'Digite sua tarefa',
                  ),
                  const SectionTitleWidget(title: '🟢 Tarefas Abertas'),
                  if (todosAbertos.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Nenhuma tarefa aberta."),
                    )
                  else
                    ...todosAbertos.map(
                      (todo) => ToDoItemWidget(
                        todo: todo,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesConstant.todoDetail,
                            arguments: ToDoDetailsEntity(todo: todo),
                          ).then((_) {
                            _bloc.add(const LoadTodosEvent());
                          });
                        },
                        onDelete: () => _bloc.add(DeleteToDoEvent(todo.id)),
                        onChanged: (completed) =>
                            _bloc.add(ToggleToDoEvent(id: todo.id, completed: completed!)),
                      ),
                    ),
                  const Divider(height: 30),
                  const SectionTitleWidget(title: '✅ Tarefas Finalizadas'),
                  if (todosConcluidos.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Nenhuma tarefa finalizada."),
                    )
                  else
                    ...todosConcluidos.map(
                      (todo) => ToDoItemWidget(
                        todo: todo,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesConstant.todoDetail,
                            arguments: ToDoDetailsEntity(todo: todo),
                          ).then((_) {
                            _bloc.add(const LoadTodosEvent());
                          });
                        },
                        onDelete: () => _bloc.add(DeleteToDoEvent(todo.id)),
                        onChanged: (completed) =>
                            _bloc.add(ToggleToDoEvent(id: todo.id, completed: completed!)),
                      ),
                    ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}