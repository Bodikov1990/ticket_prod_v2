import 'package:get_it/get_it.dart';

import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/datasource/authentication_remote_data_source.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/repositories/authentication_repository_impl.dart';
import 'package:ticket_prod_v2/src/authentication_page/repository/authentication_repository/authentication_repository.dart';
import 'package:ticket_prod_v2/src/details_page/data/datasource/details_remote_datasource.dart';
import 'package:ticket_prod_v2/src/details_page/data/repositories/details_repository_impl.dart';
import 'package:ticket_prod_v2/src/details_page/repository/details_repository.dart';

import 'package:ticket_prod_v2/src/main_page/data/datasource/main_qr_remote_datasource.dart';
import 'package:ticket_prod_v2/src/main_page/data/repositories/main_qr_repository_impl.dart';
import 'package:ticket_prod_v2/src/main_page/repository/main_qr_repository.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/datasources/repertoire_remote_datasource.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/repositories/repertoire_repository_impl.dart';
import 'package:ticket_prod_v2/src/repertoire_page/repository/repertoire_repository.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/data/datasource/rezervation_number_remote_datasource.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/data/repositories/rezervation_number_repository_impl.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/repository/rezervation_number_repository.dart';
import 'package:ticket_prod_v2/src/user/data/ropsitories/user_repository_impl.dart';
import 'package:ticket_prod_v2/src/user/repository/user_repository.dart';

final getIt = GetIt.instance;

void init() {
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

  getIt.registerLazySingleton<RezervationNumberRepository>(
      () => RezervationNumberRepositoryImpl());

  getIt.registerLazySingleton<RezervationNumberRemoteDataSource>(
      () => RezervationNumberRemoteDataSourceImpl());

  getIt.registerLazySingleton<DetailsRepository>(() => DetailsRepositoryImpl());

  getIt.registerLazySingleton<DetailsRemoteDataSource>(
      () => DetailsRemoteDataSourceImpl());

  getIt.registerLazySingleton<RepertoireRepository>(
      () => RepertoireRepositoryImpl());

  getIt.registerLazySingleton<RepertoireRemoteDataSource>(
      () => RepertoireRemoteDataSourceImpl());
}
