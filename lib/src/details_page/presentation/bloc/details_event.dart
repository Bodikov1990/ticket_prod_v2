part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

final class DetailsCheckTicketStatusEvent extends DetailsEvent {
  final TicketEntity ticketEntity;

  const DetailsCheckTicketStatusEvent({required this.ticketEntity});

  @override
  List<Object> get props => [ticketEntity];
}

final class DetailsActivateEvent extends DetailsEvent {
  final String ticketID;

  const DetailsActivateEvent({required this.ticketID});

  @override
  List<Object> get props => [ticketID];
}
