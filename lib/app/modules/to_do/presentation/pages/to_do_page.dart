import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/bloc/to_do_bloc.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/bloc/to_do_event.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/bloc/to_do_state.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/widgets/to_do_item_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ToDoBloc>().add(LoadToDoEvent());
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels + 50 >= _scroll.position.maxScrollExtent) {
      context.read<ToDoBloc>().add(LoadMoreToDoEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
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

          return ListView.builder(
            controller: _scroll,
            itemCount: state.hasMore ? state.todos.length + 1 : state.todos.length,
            itemBuilder: (_, index) {
              if (index >= state.todos.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final todo = state.todos[index];
              return ToDoItemWidget(todo: todo);
            },
          );
        },
      ),
    );
  }
}