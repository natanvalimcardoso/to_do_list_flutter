import 'package:flutter/material.dart';
import 'package:to_do_list_flutter/app/features/to_do/presentation/pages/to_do_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      home: const ToDoPage(),
    );
  }
}