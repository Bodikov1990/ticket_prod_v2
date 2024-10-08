// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

abstract class DetailsState {
  const DetailsState();
}

final class DetailsInitial extends DetailsState {}

class DetailsTicketStatusError extends DetailsState {
  final String title;
  final String message;
  const DetailsTicketStatusError({
    required this.title,
    required this.message,
  });
}

class DetailsTicketStatusNew extends DetailsState {
  final OrderEntity ticketEntity;
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
}
