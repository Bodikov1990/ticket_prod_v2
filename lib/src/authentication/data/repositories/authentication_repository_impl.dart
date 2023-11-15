import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:ticket_prod_v2/src/authentication/repository/authentication_repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource =
      GetIt.instance<AuthenticationRemoteDataSource>();

  @override
  ResultFuture<String?> authenticate(String? login, String? password) async {
    try {
      final result = await _remoteDataSource.authenticate(
          login: login, password: password);
      return Right(result);
    } on APIExeption catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }

  @override
  ResultVoid checkPing(String baseURL) async {
    try {
      await _remoteDataSource.checkPing(baseURL);
      return const Right(null);
    } on APIExeption catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }
}
