import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';

abstract class MainQRRepository {
  const MainQRRepository();

  ResultFuture<OrderEntity> getRezervation(String id);
}
