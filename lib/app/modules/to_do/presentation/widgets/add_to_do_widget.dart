import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/validations/validation_todo.dart';

class AddToDoWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final String label;

  AddToDoWidget({
    super.key,
    required this.controller,
    required this.onAdd,
    this.label = 'Add item',
  });

  final _formKey = GlobalKey<FormState>();

  void _handleAdd(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      onAdd();
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.015),
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackgroundLight,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(
                    color: isDark ? AppColors.primaryTextDark : AppColors.primaryText,
                  ),
                  decoration: InputDecoration(
                    hintText: label,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: isDark ? AppColors.secondaryTextDark : AppColors.primaryText,
                    ),
                  ),
                  validator: ValidationTodo.validateToDo,
                  onFieldSubmitted: (_) => _handleAdd(context),
                ),
              ),
              InkWell(
                onTap: () => _handleAdd(context),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.012),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accentBlue),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
