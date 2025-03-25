import 'package:flutter/material.dart';

import '../../app/modules/to_do/domain/entities/to_do_details_entity.dart';
import '../../app/modules/to_do/presentation/pages/to_do_details_page.dart';
import '../../app/modules/to_do/presentation/pages/to_do_page.dart';
import '../constants/routes_constant.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstant.todo:
        return MaterialPageRoute(builder: (_) => const ToDoPage());

      case RoutesConstant.todoDetail:
        final args = settings.arguments as ToDoDetailsEntity;
        return MaterialPageRoute(
          builder: (_) => ToDoDetailPage(todo: args.todo),
        );

      default:
        return  MaterialPageRoute(builder: (_) => const ToDoPage());
    }
  }
}