import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  TicketEntity _ticketEntity = const TicketEntity();

  String ticketStatus = '';
  String movieName = '';
  String hallName = '';
  String startTime = '';
  String seats = '';

  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsCheckTicketStatusEvent>(_checkTicketStatus);
  }

  Future<void> _checkTicketStatus(
      DetailsCheckTicketStatusEvent event, Emitter<DetailsState> emit) async {
    _ticketEntity = event.ticketEntity;

    if (_ticketEntity.status == 3) {
      emit(DetailsTicketStatusError(
          title: S.current.activated,
          message: S.current.all_tickets_activated));
      ticketStatus = S.current.tickets_activated;
      movieName = _ticketEntity.movie ?? '';
      hallName = _ticketEntity.hall ?? '';
      startTime = DateFormat('HH:mm - dd.MM.yyyy').format(startTimeFromSource);
      String seats = _buildSeatList(_ticketEntity.seats);
      emit(DetailsTicketStatusActivated(
          ticketStatus: ticketStatus,
          movieName: movieName,
          hallName: hallName,
          startTime: startTime,
          seats: seats));
    } else if (_ticketEntity.status == 2) {
      ticketStatus = S.current.new_ticket;
      movieName = _ticketEntity.movie ?? '';
      hallName = _ticketEntity.hall ?? '';
      startTime = DateFormat('HH:mm - dd.MM.yyyy').format(startTimeFromSource);
      seats = _buildSeatList(_ticketEntity.seats);
      emit(DetailsTicketStatusNew(
          ticketEntity: _ticketEntity,
          movieName: movieName,
          ticketStatus: ticketStatus,
          hallName: hallName,
          startTime: startTime,
          seats: seats));
    }
  }

  DateTime get startTimeFromSource {
    try {
      if (_ticketEntity.seanceDate == null) {
        return DateTime.fromMicrosecondsSinceEpoch(0);
      } else {
        return DateTime.parse(_ticketEntity.seanceDate?.substring(0, 19) ?? '');
      }
    } catch (ignored) {
      return DateTime.fromMicrosecondsSinceEpoch(0);
    }
  }

  String _buildSeatList(List<SeatEntity>? seats) {
    if (seats == null || seats.isEmpty) {
      return '';
    }

    Map<String, List<String>> seatRows = {};

    for (var seat in seats) {
      if (seat.row == null || seat.seat == null) {
        continue;
      }

      if (!seatRows.containsKey(seat.row)) {
        seatRows[seat.row!] = <String>[seat.seat!];
      } else {
        seatRows[seat.row!]!.add(seat.seat!);
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
