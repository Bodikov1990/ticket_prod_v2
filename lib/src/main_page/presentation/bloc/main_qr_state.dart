part of 'main_qr_bloc.dart';

abstract class MainQrState extends Equatable {}

final class MainQrInitial extends MainQrState {
  @override
  List<Object?> get props => [];
}

final class MainQrGettingRezervationState extends MainQrState {
  @override
  List<Object?> get props => [];
}

class MainQrGetRezervationSuccesState extends MainQrState {
  final TicketEntity ticket;

  MainQrGetRezervationSuccesState({required this.ticket});

  @override
  List<Object> get props => [ticket];
}

class MainQrGetRezervationErrorState extends MainQrState {
  final String message;

  MainQrGetRezervationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
