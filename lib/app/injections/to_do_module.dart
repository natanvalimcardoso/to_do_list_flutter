// lib/injections/todo_module.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/delete_to_do_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/toggle_local_to_do_completed_usecase.dart';
import 'package:to_do_list_flutter/app/modules/to_do/domain/usecases/update_local_to_do_use_casa.dart';

import '../modules/to_do/data/external/datasources/local/to_do_local_datasource_impl.dart';
import '../modules/to_do/data/infra/datasources/local/to_do_local_datasource.dart';
import '../modules/to_do/data/infra/repositories/to_do_local_repository_impl.dart';
import '../modules/to_do/domain/repositories/to_do_local_repository.dart';
import '../modules/to_do/domain/usecases/add_all_local_to_dos_usecase.dart';
import '../modules/to_do/domain/usecases/add_local_to_do_usecase.dart';
import '../modules/to_do/domain/usecases/get_local_to_dos_usecase.dart';
import '../modules/to_do/presentation/bloc/to_do_bloc.dart';

void setupTodoModule(GetIt getIt) {
  getIt.registerLazySingleton<ToDoLocalDatasource>(
    () => ToDoLocalDatasourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ToDoLocalRepository>(
    () => ToDoLocalRepositoryImpl(getIt<ToDoLocalDatasource>()),
  );

  getIt.registerLazySingleton(() => GetLocalToDosUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => AddLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => DeleteLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => ToggleLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => UpdateLocalToDoUsecase(getIt<ToDoLocalRepository>()));
  getIt.registerLazySingleton(() => AddAllLocalToDosUsecase(getIt<ToDoLocalRepository>()));

  getIt.registerLazySingleton(
    () => ToDoBloc(
      getLocalTodosUseCase: getIt<GetLocalToDosUsecase>(),
      addLocalTodoUseCase: getIt<AddLocalToDoUsecase>(),
      deleteLocalTodoUseCase: getIt<DeleteLocalToDoUsecase>(),
      toggleLocalTodoUsecase: getIt<ToggleLocalToDoUsecase>(),
      updateLocalTodoUsecase: getIt<UpdateLocalToDoUsecase>(),
      addAllLocalTodosUsecase: getIt<AddAllLocalToDosUsecase>(),
    ),
  );
}