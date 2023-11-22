// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seat_list_bloc.dart';

abstract class SeatListState {
  const SeatListState();
}

class SeatListInitial extends SeatListState {}

class SeatFilteredState extends SeatListState {
  final Map<String, List<SeatEntity>> allMapSeats;
  final Map<String, List<SeatEntity>> soldMapSeats;
  final Map<String, List<SeatEntity>> activatedMapSeats;
  const SeatFilteredState({
    required this.allMapSeats,
    required this.soldMapSeats,
    required this.activatedMapSeats,
  });
}

class SeatActivatedState extends SeatListState {
  final String title;
  final String message;
  SeatActivatedState({
    required this.title,
    required this.message,
  });
}

class SeatActivateErrorState extends SeatListState {
  final String title;
  final String message;
  SeatActivateErrorState({
    required this.title,
    required this.message,
  });
}
