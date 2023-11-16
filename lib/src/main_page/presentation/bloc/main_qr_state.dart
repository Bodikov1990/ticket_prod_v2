part of 'main_qr_bloc.dart';

abstract class MainQrState extends Equatable {
  const MainQrState();

  @override
  List<Object> get props => [];
}

final class MainQrInitial extends MainQrState {}

final class MainQrGettingRezervationState extends MainQrState {}

final class MainQrGetRezervationSuccesState extends MainQrState {
  final TicketEntity ticket;

  const MainQrGetRezervationSuccesState({required this.ticket});

  @override
  List<Object> get props => [ticket];
}

final class MainQrGetRezervationErrorState extends MainQrState {
  final String message;

  const MainQrGetRezervationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
