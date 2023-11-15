import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/authentication/repository/authentication_repository/authentication_repository.dart';

class ChecPingUseCase extends UsecaseWithParams<void, CheckPingUseCaseParams> {
  final AuthenticationRepository _repository =
      GetIt.instance<AuthenticationRepository>();

  @override
  ResultFuture<void> call(CheckPingUseCaseParams params) async =>
      _repository.checkPing(params.baseURL);
}

class CheckPingUseCaseParams {
  final String baseURL;

  CheckPingUseCaseParams({required this.baseURL});
}
