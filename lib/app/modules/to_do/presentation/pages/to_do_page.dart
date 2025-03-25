import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/routes_constant.dart';
import '../../../../../core/themes/theme_controller.dart';
import '../../../../injections/injection_container.dart';
import '../../domain/entities/to_do_details_entity.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';
import '../bloc/to_do_state.dart';
import '../widgets/add_to_do_widget.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/section_title_widget.dart';
import '../widgets/to_do_item_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final ToDoBloc _bloc = getIt<ToDoBloc>()..add(const SyncToDosEvent());
  final TextEditingController _todoController = TextEditingController();
  final themeController = getIt<ThemeController>();

  @override
  void dispose() {
    _todoController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          onPlanetPressed: () {
            _bloc.add(const SyncToDosEvent());
          },
          onThemePressed: () {
            themeController.toggleTheme();
          },
        ),
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
                    onAdd: () {
                      _bloc.add(AddToDoEvent(_todoController.text.trim()));
                    },
                  ),
                  Divider(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1)),
                  const SectionTitleWidget(title: 'TO DO'),
                  if (todosAbertos.isEmpty)
                    Text("Nenhuma tarefa aberta.")
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
                        onChanged:
                            (completed) =>
                                _bloc.add(ToggleToDoEvent(id: todo.id, completed: completed!)),
                      ),
                    ),
                  const SectionTitleWidget(title: 'COMPLETED'),
                  if (todosConcluidos.isEmpty)
                    Center(child: Text("Nenhuma tarefa finalizada."))
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
                        onChanged:
                            (completed) =>
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
