import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injections/injection_container.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';
import '../bloc/to_do_state.dart';
import '../../domain/entities/to_do_entity.dart';

class ToDoDetailPage extends StatefulWidget {
  final ToDoEntity todo;

  const ToDoDetailPage({super.key, required this.todo});

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  final TextEditingController _editController = TextEditingController();
  final ToDoBloc _bloc = getIt<ToDoBloc>(); 

  @override
  void initState() {
    super.initState();
      _editController.text = widget.todo.todo;
    _bloc.add(EditingTodoChangedEvent(widget.todo));
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  void _deleteToDo() {
    _bloc.add(DeleteToDoEvent(widget.todo.id));
    Navigator.pop(context);
  }

  void _saveEdit() {
    _bloc.add(const SaveTodoChangesEvent());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Tarefa'),
          actions: [
            IconButton( icon: const Icon(Icons.delete), onPressed: _deleteToDo),
          ],
        ),
        body: BlocBuilder<ToDoBloc, ToDoState>(
          builder: (context, state) {
            final currentTodo = (state is EditingToDoState) 
             ? state.todoBeingEdited 
             : widget.todo;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Editar Tarefa:', style: TextStyle(fontSize: 18)),
                  TextFormField(
                    controller: _editController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), 
                      labelText: 'Descrição da tarefa',
                    ),
                    onChanged: (val) {
                      _bloc.add(EditingTodoChangedEvent(
                        currentTodo.copyWith(todo: val.trim()),
                      ));
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Finalizar tarefa?', style: TextStyle(fontSize: 16)),
                      Checkbox(
                        value: currentTodo.completed,
                        onChanged: (bool? value) {
                          _bloc.add(EditingTodoChangedEvent(
                            currentTodo.copyWith(completed: value!),
                          ));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: _saveEdit,
                    child: const Text('Salvar alterações'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}