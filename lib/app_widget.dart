import 'package:flutter/material.dart';
import 'core/constants/routes_constant.dart';
import 'core/routes/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesConstant.todo,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
