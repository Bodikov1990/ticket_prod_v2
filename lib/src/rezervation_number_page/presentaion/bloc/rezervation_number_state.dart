// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rezervation_number_bloc.dart';

abstract class RezervationNumberState extends Equatable {
  const RezervationNumberState();

  @override
  List<Object?> get props => [];
}

class RezervationNumberInitial extends RezervationNumberState {}

class RezervationNumberLoadingState extends RezervationNumberState {}

class RezervationGetUserSuccesState extends RezervationNumberState {
  final String? prefix;
  const RezervationGetUserSuccesState({
    required this.prefix,
  });

  @override
  List<Object?> get props => [prefix];
}

class RezervationGetTicketSuccesState extends RezervationNumberState {
  final TicketEntity ticketEntity;
  const RezervationGetTicketSuccesState({
    required this.ticketEntity,
  });

  @override
  List<Object> get props => [ticketEntity];
}

class RezervationGetTicketErrorState extends RezervationNumberState {
  final String title;
  final String message;
  const RezervationGetTicketErrorState({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}
