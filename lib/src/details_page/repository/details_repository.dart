import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

abstract class DetailsRepository {
  const DetailsRepository();

  ResultVoid activate(
      {required String ticketID, required List<SeatEntity> seats});
}
