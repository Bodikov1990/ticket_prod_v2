part of 'details_bloc.dart';

abstract class DetailsEvent {
  const DetailsEvent();
}

final class DetailsCheckTicketStatusEvent extends DetailsEvent {
  final OrderEntity ticketEntity;

  const DetailsCheckTicketStatusEvent({required this.ticketEntity});
}

final class DetailsActivateEvent extends DetailsEvent {
  final String ticketID;

  const DetailsActivateEvent({required this.ticketID});
}
