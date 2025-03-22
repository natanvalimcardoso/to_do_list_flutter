// lib/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:to_do_list_flutter/app/features/to_do/data/external/datasources/local/to_do_local_datasource_impl.dart';
import 'package:to_do_list_flutter/app/features/to_do/data/external/datasources/remote/to_do_remote_datasource_impl.dart';
import 'package:to_do_list_flutter/app/features/to_do/data/infra/datasources/local/to_do_local_datasource.dart';
import 'package:to_do_list_flutter/app/features/to_do/data/infra/datasources/remote/to_do_remote_datasource.dart';
import 'package:to_do_list_flutter/app/features/to_do/data/infra/repositories/to_do_local_repository_impl.dart';
import 'package:to_do_list_flutter/app/features/to_do/data/infra/repositories/to_do_remote_repository_impl.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/repositories/to_do_local_repository.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/repositories/to_do_remote_repository.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/usecases/add_local_to_do_usecase.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/usecases/delete_to_do_usecase.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/usecases/get_local_to_do_usecase.dart';
import 'package:to_do_list_flutter/app/features/to_do/domain/usecases/get_remote_to_do_usecase.dart' show GetRemoteToDosUsecase;
import 'package:to_do_list_flutter/app/features/to_do/domain/usecases/toggle_local_to_do_completed_usecase.dart';
import 'package:to_do_list_flutter/app/features/to_do/presentation/bloc/to_do_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupProviders() async {
  // External dependencies
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Datasources
  getIt.registerLazySingleton<ToDoRemoteDatasource>(
    () => ToDoRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ToDoLocalDatasource>(
    () => ToDoLocalDatasourceImpl(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<ToDoRemoteRepository>(
    () => TodoRemoteRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ToDoLocalRepository>(
    () => ToDoLocalRepositoryImpl(getIt()),
  );

  // Usecases
  getIt.registerLazySingleton(() => GetRemoteToDosUsecase(getIt()));
  getIt.registerLazySingleton(() => GetLocalToDosUsecase(getIt()));
  getIt.registerLazySingleton(() => AddLocalToDoUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteLocalToDoUsecase(getIt()));
  getIt.registerLazySingleton(() => ToggleLocalToDoCompletedUsecase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => ToDoBloc(
      getRemoteToDosUsecase: getIt(),
      getLocalTodosUseCase: getIt(),
      addLocalTodoUseCase: getIt(),
      deleteLocalTodoUseCase: getIt(),
      toggleLocalTodoCompletedUseCase: getIt(),
    ),
  );
}