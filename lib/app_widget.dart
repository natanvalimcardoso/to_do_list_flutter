import 'package:flutter/material.dart';

import 'app/injections/injection_container.dart';
import 'core/constants/routes_constant.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/theme_controller.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = getIt<ThemeController>();

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (_, themeMode, __) {
        return MaterialApp(
          title: 'ToDo List',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          initialRoute: RoutesConstant.todo,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}