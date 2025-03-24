// lib/injections/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:to_do_list_flutter/app/modules/to_do/to_do_module_injection.dart';

import 'core_module_injection.dart';

final getIt = GetIt.instance;

Future<void> setupProviders() async {
  await setupCoreModule(getIt);
  setupTodoModule(getIt);
}