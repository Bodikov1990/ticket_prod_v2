import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/details_page/domain/entities/activate_entity.dart';
import 'package:ticket_prod_v2/src/details_page/repository/details_repository.dart';

class ActivateUseCase extends UsecaseWithParams<void, ActivateUseCaseParams> {
  final DetailsRepository _repository = GetIt.instance<DetailsRepository>();

  @override
  ResultFuture<void> call(ActivateUseCaseParams params) async =>
      _repository.activate(
          ticketID: params.ticketID, activateEntity: params.activateEntity);
}

class ActivateUseCaseParams {
  final String ticketID;
  final ActivateEntity activateEntity;

  ActivateUseCaseParams({required this.ticketID, required this.activateEntity});
}
