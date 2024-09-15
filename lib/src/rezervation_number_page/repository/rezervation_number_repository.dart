import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';

abstract class RezervationNumberRepository {
  ResultFuture<OrderEntity> getRezervation(String number);
}
