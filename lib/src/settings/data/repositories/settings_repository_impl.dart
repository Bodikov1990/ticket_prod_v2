import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/settings/data/datasource/settings_local_datasource.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';
import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource =
      GetIt.instance<SettingsLocalDataSource>();

  @override
  ResultFuture<UserModel> getUser() async {
    return await _localDataSource.getUser();
  }

  @override
  ResultVoid saveUser(UserModel user) async {
    try {
      await _localDataSource.saveUser(user);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromExeption(e));
    }
  }
}
