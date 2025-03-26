import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injections/injection_container.dart';
import '../../domain/entities/to_do_entity.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';

class ToDoDetailPage extends StatefulWidget {
  final ToDoEntity todo;

  const ToDoDetailPage({required this.todo, super.key});

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
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Tarefa'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _bloc.add(DeleteToDoEvent(widget.todo.id));
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
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
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Finalizar tarefa?', style: TextStyle(fontSize: 16)),
                  Checkbox(
                    value: widget.todo.completed,
                    onChanged: (bool? completed) {
                      final editedTodo = widget.todo.copyWith(completed: completed!);
                      _bloc.add(UpdateToDoEvent(editedTodo));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  final editedTodo = widget.todo.copyWith(todo: _editController.text.trim());

                  if (editedTodo.todo.isNotEmpty) {
                    _bloc.add(UpdateToDoEvent(editedTodo));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
