import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/seat_list_bloc.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  TicketEntity _ticketEntity = const TicketEntity();
  final seatListBloc = SeatListBloc();

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
      emit(const DetailsTicketStatusError(
          title: "Активирован", message: "Все билеты уже активированы!"));
      ticketStatus = 'Билеты уже активированы! ❗';
      movieName = _ticketEntity.movie ?? '';
      hallName = _ticketEntity.hall ?? '';
      startTime = DateFormat('yyyy.MM.dd HH:mm').format(startTimeFromSource);
      String seats = _buildSeatList(_ticketEntity.seats);
      emit(DetailsTicketStatusActivated(
          ticketStatus: ticketStatus,
          movieName: movieName,
          hallName: hallName,
          startTime: startTime,
          seats: seats));
    } else if (_ticketEntity.status == 2) {
      ticketStatus = 'Новый ✅';
      movieName = _ticketEntity.movie ?? '';
      hallName = _ticketEntity.hall ?? '';
      startTime = DateFormat('yyyy.MM.dd HH:mm').format(startTimeFromSource);
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
      seatStrings.add('Ряд: $row Места: $seatList');
    });

    return seatStrings.join('\n');
  }
}
