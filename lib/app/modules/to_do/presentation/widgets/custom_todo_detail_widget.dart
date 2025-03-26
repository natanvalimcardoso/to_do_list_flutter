import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/validations/validation_todo.dart';

class CustomTodoDetailWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isDark;
  final VoidCallback? onAddPressed;
  final VoidCallback? onFieldSubmitted;

  const CustomTodoDetailWidget({
    required this.controller, 
    required this.label, 
    super.key,
    this.isDark = false,
    this.onAddPressed,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTodoDetailWidget> createState() => _CustomTodoDetailWidgetState();
}

class _CustomTodoDetailWidgetState extends State<CustomTodoDetailWidget> {
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      widget.onAddPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            color: widget.isDark ? AppColors.primaryTextDark : AppColors.primaryText,
          ),
          decoration: InputDecoration(
            hintText: widget.label,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: widget.isDark ? AppColors.secondaryTextDark : AppColors.primaryText,
            ),
          ),
          validator: ValidationTodo.validateToDo,
          onFieldSubmitted: (_) => _handleSubmit(context),
        ),
      ),
    );
  }
}