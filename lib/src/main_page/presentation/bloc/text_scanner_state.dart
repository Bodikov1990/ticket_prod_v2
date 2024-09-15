// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'text_scanner_bloc.dart';

abstract class TextScannerState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TextScannerInitial extends TextScannerState {}

final class TextScannerLoadingState extends TextScannerState {}

class TextScannerPrefixLoadedState extends TextScannerState {
  final String prefix;

  TextScannerPrefixLoadedState({
    required this.prefix,
  });

  @override
  List<Object> get props => [prefix];
}

class TextScannerLoadingErrorState extends TextScannerState {
  final String title;
  final String message;
  TextScannerLoadingErrorState({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}

class TextScannerGetTicketSuccesState extends TextScannerState {
  final OrderEntity ticketEntity;
  TextScannerGetTicketSuccesState({
    required this.ticketEntity,
  });

  @override
  List<Object> get props => [ticketEntity];
}
