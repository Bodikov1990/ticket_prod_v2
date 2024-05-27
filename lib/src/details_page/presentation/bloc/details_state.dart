// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {}

class DetailsTicketStatusError extends DetailsState {
  final String title;
  final String message;
  const DetailsTicketStatusError({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}

class DetailsTicketStatusNew extends DetailsState {
  final TicketEntity ticketEntity;
  final String ticketStatus;
  final String movieName;
  final String hallName;
  final String startTime;
  final String seats;
  const DetailsTicketStatusNew({
    required this.ticketEntity,
    required this.ticketStatus,
    required this.movieName,
    required this.hallName,
    required this.startTime,
    required this.seats,
  });

  @override
  List<Object> get props =>
      [ticketEntity, ticketStatus, movieName, hallName, startTime, seats];
}

class DetailsTicketStatusActivated extends DetailsState {
  final String alertTitle;
  final String alertMessage;
  final String ticketStatus;
  final String movieName;
  final String hallName;
  final String startTime;
  final String seats;
  const DetailsTicketStatusActivated({
    required this.alertTitle,
    required this.alertMessage,
    required this.ticketStatus,
    required this.movieName,
    required this.hallName,
    required this.startTime,
    required this.seats,
  });

  @override
  List<Object> get props =>
      [ticketStatus, movieName, hallName, startTime, seats];
}
