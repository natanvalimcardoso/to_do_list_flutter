import 'package:flutter_modular/flutter_modular.dart';
import 'package:to_do_list_flutter/app/modules/to_do/presentation/pages/to_do_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => ToDoPage());
  }
}
