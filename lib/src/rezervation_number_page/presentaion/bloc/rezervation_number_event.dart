// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rezervation_number_bloc.dart';

abstract class RezervationNumberEvent extends Equatable {
  const RezervationNumberEvent();

  @override
  List<Object> get props => [];
}

class RezervationGetUserEvent extends RezervationNumberEvent {}

class RezervationGetNumberEvent extends RezervationNumberEvent {
  final String number;
  const RezervationGetNumberEvent({
    required this.number,
  });
}
