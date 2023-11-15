import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';
import 'package:ticket_prod_v2/src/user/repository/user_repository.dart';

class GetUserUseCase extends UsecaseWithoutParams {
  final UserRepository _repository = GetIt.instance<UserRepository>();

  @override
  ResultFuture<UserModel> call() async => _repository.getUser();
}
