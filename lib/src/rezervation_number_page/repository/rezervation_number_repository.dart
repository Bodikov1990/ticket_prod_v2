import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

abstract class RezervationNumberRepository {
  ResultFuture<TicketEntity> getRezervation(String number);
}
