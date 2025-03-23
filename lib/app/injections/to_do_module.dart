// lib/injections/todo_module.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/repositories/to_do_local_repository_impl.dart';
import 'package:to_do_list_flutter/app/modules/to_do/data/infra/repositories/to_do_remote_repository_impl.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/add_all_local_to_dos_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/update_local_to_do_use_casa.dart';

import '../modules/to_do/data/external/datasources/local/to_do_local_datasource_impl.dart';
import '../modules/to_do/data/external/datasources/remote/to_do_remote_datasource_impl.dart';
import '../modules/to_do/data/infra/datasources/local/to_do_local_datasource.dart';
import '../modules/to_do/data/infra/datasources/remote/to_do_remote_datasource.dart';
import '../modules/to_do/domain/repositories/to_do_local_repository.dart';
import '../modules/to_do/domain/repositories/to_do_remote_repository.dart';
import '../modules/to_do/domain/usecases/add_local_to_do_usecase.dart';
import '../modules/to_do/domain/usecases/delete_to_do_usecase.dart';
import '../modules/to_do/domain/usecases/get_local_to_dos_usecase.dart';
import '../modules/to_do/domain/usecases/get_remote_to_dos_usecase.dart';
import '../modules/to_do/domain/usecases/toggle_local_to_do_completed_usecase.dart';
import '../modules/to_do/presentation/bloc/to_do_bloc.dart';

void setupTodoModule(GetIt getIt) {
  // Datasources
  getIt.registerLazySingleton<ToDoRemoteDatasource>(() => ToDoRemoteDatasourceImpl(getIt<Dio>()));

  getIt.registerLazySingleton<ToDoLocalDatasource>(
    () => ToDoLocalDatasourceImpl(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<ToDoRemoteRepository>(
    () => ToDoRemoteRepositoryImpl(getIt<ToDoRemoteDatasource>()),
  );

  getIt.registerLazySingleton<ToDoLocalRepository>(
    () => ToDoLocalRepositoryImpl(getIt<ToDoLocalDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton(() => GetRemoteToDosUsecase(getIt<ToDoRemoteRepository>()));
  getIt.registerLazySingleton(() => GetLocalToDosUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => AddLocalToDoUsecase(getIt<ToDoLocalRepository>(), getIt<GetLocalToDosUsecase>()));
  getIt.registerLazySingleton(() => DeleteLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => ToggleLocalToDoCompletedUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => AddAllLocalToDosUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => UpdateLocalTodoUsecase(getIt<ToDoLocalRepository>()));
  // Bloc
  getIt.registerLazySingleton(
    () => ToDoBloc(
      getRemoteToDosUsecase: getIt<GetRemoteToDosUsecase>(),
      getLocalTodosUseCase: getIt<GetLocalToDosUsecase>(),
      addLocalTodoUseCase: getIt<AddLocalToDoUsecase>(),
      deleteLocalTodoUseCase: getIt<DeleteLocalToDoUsecase>(),
      toggleLocalTodoCompletedUseCase: getIt<ToggleLocalToDoCompletedUsecase>(),
      addAllLocalTodosUseCase: getIt<AddAllLocalToDosUsecase>(),
      updateLocalTodoUsecase: getIt<UpdateLocalTodoUsecase>(),
    ),
  );
}
