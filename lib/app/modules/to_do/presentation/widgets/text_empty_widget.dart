import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class TextEmptyWidget extends StatelessWidget {
  final String text;
  const TextEmptyWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.secondaryText),
      ),
    );
  }
}
