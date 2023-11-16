import 'package:get_it/get_it.dart';

import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/datasource/authentication_remote_data_source.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/repositories/authentication_repository_impl.dart';
import 'package:ticket_prod_v2/src/authentication_page/repository/authentication_repository/authentication_repository.dart';

import 'package:ticket_prod_v2/src/main_page/data/datasource/main_qr_remote_datasource.dart';
import 'package:ticket_prod_v2/src/main_page/data/repositories/main_qr_repository_impl.dart';
import 'package:ticket_prod_v2/src/main_page/repository/main_qr_repository.dart';
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
  getIt.registerLazySingleton<MainQRRepository>(() => MainQRRepositoryImpl());
  getIt.registerLazySingleton<MainQRRemoteDataSource>(
      () => MainQRRemoteDataSourceImpl());
}
