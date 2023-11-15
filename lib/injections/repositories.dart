import 'package:get_it/get_it.dart';

import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:ticket_prod_v2/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:ticket_prod_v2/src/authentication/repository/authentication_repository/authentication_repository.dart';
import 'package:ticket_prod_v2/src/user/data/ropsitories/user_repository_impl.dart';
import 'package:ticket_prod_v2/src/user/repository/user_repository.dart';

final getIt = GetIt.instance;

void init(Environment env) {
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}
