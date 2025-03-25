// lib/injections/todo_module.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'data/external/datasources/to_do_local_datasource_impl.dart';
import 'data/external/datasources/to_do_remote_datasource_impl.dart';
import 'data/infra/datasources/to_do_local_datasource.dart';
import 'data/infra/datasources/to_do_remote_datasource.dart';
import 'data/infra/repositories/to_do_local_repository_impl.dart';
import 'data/infra/repositories/to_do_remote_repository_impl.dart';
import 'domain/repositories/to_do_local_repository.dart';
import 'domain/repositories/to_do_remote_repository.dart';
import 'domain/usecases/add_all_local_to_dos_usecase.dart';
import 'domain/usecases/add_local_to_do_usecase.dart';
import 'domain/usecases/delete_to_do_usecase.dart';
import 'domain/usecases/get_local_to_dos_usecase.dart';
import 'domain/usecases/sync_to_dos_usecase.dart';
import 'domain/usecases/toggle_local_to_do_completed_usecase.dart';
import 'domain/usecases/update_local_to_do_use_casa.dart';
import 'presentation/bloc/to_do_bloc.dart';

void setupTodoModule(GetIt getIt) {
  // DataSources
  getIt.registerLazySingleton<ToDoLocalDatasource>(
    () => ToDoLocalDatasourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ToDoRemoteDatasource>(
    () => ToDoRemoteDatasourceImpl(getIt<Dio>()),
  );

  // Repositories
  getIt.registerLazySingleton<ToDoLocalRepository>(
    () => ToDoLocalRepositoryImpl(getIt<ToDoLocalDatasource>()),
  );

  getIt.registerLazySingleton<ToDoRemoteRepository>(
    () => ToDoRemoteRepositoryImpl(getIt<ToDoRemoteDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton(() => GetLocalToDosUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => AddLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => DeleteLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => ToggleLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => UpdateLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => AddAllLocalToDosUsecase(getIt<ToDoLocalRepository>()));

  getIt.registerLazySingleton(
    () => SyncToDosUsecase(
      localRepository: getIt<ToDoLocalRepository>(),
      remoteRepository: getIt<ToDoRemoteRepository>(),
    ),
  );

  // Bloc
  getIt.registerLazySingleton(
    () => ToDoBloc(
      getLocalTodosUseCase: getIt<GetLocalToDosUsecase>(),
      addLocalTodoUseCase: getIt<AddLocalToDoUsecase>(),
      deleteLocalTodoUseCase: getIt<DeleteLocalToDoUsecase>(),
      toggleLocalTodoUsecase: getIt<ToggleLocalToDoUsecase>(),
      updateLocalTodoUsecase: getIt<UpdateLocalToDoUsecase>(),
      addAllLocalTodosUsecase: getIt<AddAllLocalToDosUsecase>(),
      syncToDosUsecase: getIt<SyncToDosUsecase>(),
    ),
  );
}