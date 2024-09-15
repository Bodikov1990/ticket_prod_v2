import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';

import 'package:ticket_prod_v2/src/details_page/repository/details_repository.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_seat_entity.dart';

class ActivateUseCase extends UsecaseWithParams<void, ActivateUseCaseParams> {
  final DetailsRepository _repository = GetIt.instance<DetailsRepository>();

  @override
  ResultFuture<void> call(ActivateUseCaseParams params) async =>
      _repository.activate(ticketID: params.ticketID, seats: params.seats);
}

class ActivateUseCaseParams {
  final String ticketID;
  final List<OrderSeatEntity> seats;

  ActivateUseCaseParams({required this.ticketID, required this.seats});
}
