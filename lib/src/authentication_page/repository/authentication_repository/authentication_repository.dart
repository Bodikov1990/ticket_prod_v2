import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/models/auth_data_model.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid checkPing(String baseURL);
  ResultFuture<AuthDataModel?> authenticate(
      String? login, String? password, String? baseURL);
}
