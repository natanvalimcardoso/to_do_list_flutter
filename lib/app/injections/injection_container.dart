// lib/injections/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:to_do_list_flutter/app/injections/to_do_module.dart';

import 'core_module.dart';

final getIt = GetIt.instance;

Future<void> setupProviders() async {
  await setupCoreModule(getIt);
  setupTodoModule(getIt);
}