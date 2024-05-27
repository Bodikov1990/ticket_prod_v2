// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seat_list_bloc.dart';

abstract class SeatListEvent {
  const SeatListEvent();
}

class SeatFilterEvent extends SeatListEvent {
  final List<SeatEntity> seats;
  const SeatFilterEvent({
    required this.seats,
  });
}

class SeatAddEvent extends SeatListEvent {
  final String discountName;

  const SeatAddEvent({required this.discountName});
}

class SeatRemoveEvent extends SeatListEvent {
  final String discountName;

  const SeatRemoveEvent({required this.discountName});
}

class SeatActivateEvent extends SeatListEvent {
  final String ticketID;

  SeatActivateEvent({required this.ticketID});
}

class SeatClearEvent extends SeatListEvent {}
