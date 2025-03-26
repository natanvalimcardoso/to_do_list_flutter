import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/themes/theme_controller.dart';

Future<void> setupCoreModule(GetIt getIt) async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  final dio = Dio();
  getIt.registerLazySingleton<Dio>(() => dio);

   getIt.registerLazySingleton(() => ThemeController());
}
