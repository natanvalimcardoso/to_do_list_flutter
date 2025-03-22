import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/network/api_endpoint.dart';
import 'to_do/data/external/datasources/remote/to_do_remote_datasource_impl.dart';
import 'to_do/data/infra/datasources/remote/to_do_remote_datasource.dart';
import 'to_do/data/infra/repositories/to_do_repository_impl.dart';
import 'to_do/domain/repositories/to_do_repository.dart';
import 'to_do/domain/usecases/get_to_do_use_case.dart';
import 'to_do/presentation/bloc/to_do_bloc.dart';
import 'to_do/presentation/pages/to_do_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: ApiEndpoint.baseUrl)));
    i.addLazySingleton<ToDoRemoteDatasource>(ToDoRemoteDatasourceImpl.new);
    i.addLazySingleton<ToDoRepository>(TodoRepositoryImpl.new);
    i.addLazySingleton<GetToDoUseCase>(GetToDoUseCase.new);
    i.addLazySingleton<ToDoBloc>(ToDoBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => BlocProvider(create: (_) => Modular.get<ToDoBloc>(), child: const ToDoPage()),
    );
  }
}
