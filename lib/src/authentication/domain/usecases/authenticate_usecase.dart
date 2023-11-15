import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/authentication/repository/authentication_repository/authentication_repository.dart';

class AuthenticateUseCase
    extends UsecaseWithParams<String?, AuthenticateUseCaseParams> {
  final AuthenticationRepository _repository =
      GetIt.instance<AuthenticationRepository>();

  @override
  ResultFuture<String?> call(AuthenticateUseCaseParams params) async =>
      _repository.authenticate(params.login, params.password);
}

class AuthenticateUseCaseParams {
  final String? login;
  final String? password;

  const AuthenticateUseCaseParams(
      {required this.login, required this.password});

  const AuthenticateUseCaseParams.empty()
      : this(login: "_empty.login", password: "_empty.password");
}
