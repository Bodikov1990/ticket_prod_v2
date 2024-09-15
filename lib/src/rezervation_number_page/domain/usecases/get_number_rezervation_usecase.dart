import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/repository/rezervation_number_repository.dart';

class GetNumberRezervationUseCase
    extends UsecaseWithParams<OrderEntity, GetNumberRezervationUseCaseParams> {
  final RezervationNumberRepository _repository =
      GetIt.instance<RezervationNumberRepository>();

  @override
  ResultFuture<OrderEntity> call(params) async =>
      _repository.getRezervation(params.number);
}

class GetNumberRezervationUseCaseParams {
  final String number;

  GetNumberRezervationUseCaseParams({required this.number});
}
