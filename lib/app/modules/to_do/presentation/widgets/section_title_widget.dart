import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.06),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
