import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/main_page/repository/main_qr_repository.dart';

class GetRezervationUseCase
    extends UsecaseWithParams<OrderEntity, GetRezervationUseCaseParams> {
  final MainQRRepository _repository = GetIt.instance<MainQRRepository>();

  @override
  ResultFuture<OrderEntity> call(params) async =>
      _repository.getRezervation(params.id);
}

class GetRezervationUseCaseParams {
  final String id;

  GetRezervationUseCaseParams({required this.id});
}
