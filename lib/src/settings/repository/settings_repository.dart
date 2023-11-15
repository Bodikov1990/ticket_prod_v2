import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';

abstract class SettingsRepository {
  ResultFuture<UserModel> getUser();
  ResultVoid saveUser(UserModel user);
}
