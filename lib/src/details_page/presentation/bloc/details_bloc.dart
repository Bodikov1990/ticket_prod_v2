import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_seat_entity.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsCheckTicketStatusEvent>(_checkTicketStatus);
  }

  Future<void> _checkTicketStatus(
      DetailsCheckTicketStatusEvent event, Emitter<DetailsState> emit) async {
    if (event.ticketEntity.status == 3) {
      emit(DetailsTicketStatusActivated(
          alertTitle: S.current.activated,
          alertMessage: S.current.all_tickets_activated,
          ticketStatus: S.current.tickets_activated,
          movieName: event.ticketEntity.movie ?? '',
          hallName: event.ticketEntity.hall ?? '',
          startTime: DateFormat('HH:mm - dd.MM.yyyy')
              .format(_startTimeFromSource(event.ticketEntity.seanceDate)),
          seats: _buildSeatList(event.ticketEntity.seats)));
    } else if (event.ticketEntity.status == 2) {
      emit(DetailsTicketStatusNew(
          ticketEntity: event.ticketEntity,
          movieName: event.ticketEntity.movie ?? '',
          ticketStatus: S.current.new_ticket,
          hallName: event.ticketEntity.hall ?? '',
          startTime: DateFormat('HH:mm - dd.MM.yyyy')
              .format(_startTimeFromSource(event.ticketEntity.seanceDate)),
          seats: _buildSeatList(event.ticketEntity.seats)));
    }
  }

  DateTime _startTimeFromSource(String? seanceDate) {
    try {
      if (seanceDate == null) {
        return DateTime.fromMicrosecondsSinceEpoch(0);
      } else {
        return DateTime.parse(seanceDate.substring(0, 19));
      }
    } catch (ignored) {
      return DateTime.fromMicrosecondsSinceEpoch(0);
    }
  }

  String _buildSeatList(List<OrderSeatEntity>? seats) {
    if (seats == null || seats.isEmpty) {
      return '';
    }

    Map<String, List<String>> seatRows = {};

    for (var seat in seats) {
      if (seat.row == null || seat.col == null) {
        continue;
      }

      if (!seatRows.containsKey(seat.row)) {
        seatRows[seat.row!] = <String>[seat.col!];
      } else {
        seatRows[seat.row!]!.add(seat.col!);
      }
    }

    List<String> seatStrings = [];
    seatRows.forEach((row, seats) {
      String seatList = seats.join(', ');
      seatStrings.add('${S.current.row}: $row ${S.current.seats}: $seatList');
    });

    return seatStrings.join('\n');
  }
}
