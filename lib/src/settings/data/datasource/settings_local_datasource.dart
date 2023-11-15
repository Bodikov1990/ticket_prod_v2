import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';
import 'package:ticket_prod_v2/src/user/repository/user_repository.dart';

abstract class SettingsLocalDataSource {
  ResultFuture<UserModel> getUser();
  ResultVoid saveUser(UserModel user);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  @override
  ResultFuture<UserModel> getUser() async {
    return await _userRepository.getUser();
  }

  @override
  ResultVoid saveUser(UserModel user) async {
    try {
      await _userRepository.saveUser(user);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromExeption(e));
    }
  }
}
