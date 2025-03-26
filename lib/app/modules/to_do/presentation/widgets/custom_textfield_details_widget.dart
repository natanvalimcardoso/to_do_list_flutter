import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final int maxLines;
  final int minLines;

  const CustomTextfieldWidget({
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon, color: theme.colorScheme.primary),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: size.width * 0.04,
          color: theme.colorScheme.secondary,
        ),
      ),
      style: TextStyle(
        fontSize: size.width * 0.04,
        color: theme.textTheme.bodyLarge?.color,
      ),
    );
  }
}

