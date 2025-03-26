import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/image_assets_constant.dart';
import '../../../../../core/themes/app_fonts.dart';
import '../../../../../core/utils/validations/validation_todo.dart';
import '../../../../injections/injection_container.dart';
import '../../domain/entities/to_do_entity.dart';
import '../bloc/to_do_bloc.dart';
import '../bloc/to_do_event.dart';
import '../widgets/custom_checkbox_widget.dart';
import '../widgets/custom_details_button_widget.dart';
import '../widgets/custom_textfield_details_widget.dart';

class ToDoDetailPage extends StatefulWidget {
  final ToDoEntity todo;

  const ToDoDetailPage({required this.todo, super.key});

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  final TextEditingController _editController = TextEditingController();
  final ToDoBloc _bloc = getIt<ToDoBloc>();
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _editController.text = widget.todo.todo;
    _isCompleted = widget.todo.completed;
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalhes da Tarefa',
            style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete, size: size.width * 0.06),
              onPressed: () {
                _bloc.add(DeleteToDoEvent(widget.todo.id));
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  ImageAssetsConstant.logo,
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                ),
                SizedBox(height: size.height * 0.04),
                CustomTextfieldWidget(
                  controller: _editController,
                  label: 'Descrição da tarefa',
                  icon: Icons.edit,
                  validator: ValidationTodo.validateToDoDetails,
                  maxLines: 3,
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    const Text('Tarefa concluída: ', style: AppFonts.roboto16w400),
                    Transform.scale(
                      scale: 1.4,
                      child: CustomCheckbox(
                        value: _isCompleted,
                        onChanged: (bool? completed) {
                          setState(() {
                            _isCompleted = completed ?? false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.25),
                CustomDetailsButtonWidget(
                  onPressed: () {
                    final editedTodo = widget.todo.copyWith(
                      todo: _editController.text.trim(),
                      completed: _isCompleted,
                    );
                    _bloc.add(UpdateToDoEvent(editedTodo));
                    Navigator.pop(context);
                  },
                  buttonText: 'Salvar alterações',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
