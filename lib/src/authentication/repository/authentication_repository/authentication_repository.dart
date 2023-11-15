import 'package:ticket_prod_v2/core/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid checkPing(String baseURL);
  ResultFuture<String?> authenticate(String? login, String? password);
}
