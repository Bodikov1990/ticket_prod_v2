import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/models/auth_data_model.dart';
import 'package:ticket_prod_v2/src/authentication_page/repository/authentication_repository/authentication_repository.dart';

class AuthenticateUseCase
    extends UsecaseWithParams<AuthDataModel?, AuthenticateUseCaseParams> {
  final AuthenticationRepository _repository =
      GetIt.instance<AuthenticationRepository>();

  @override
  ResultFuture<AuthDataModel?> call(AuthenticateUseCaseParams params) async =>
      _repository.authenticate(params.login, params.password, params.baseURL);
}

class AuthenticateUseCaseParams {
  final String? login;
  final String? password;
  final String? baseURL;

  const AuthenticateUseCaseParams(
      {required this.login, required this.password, this.baseURL});

  const AuthenticateUseCaseParams.empty()
      : this(login: "_empty.login", password: "_empty.password");
}
