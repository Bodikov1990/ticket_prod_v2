// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'repertoire_bloc.dart';

abstract class RepertoireEvent extends Equatable {}

class RepertoireLoadingEvent extends RepertoireEvent {
  final String date;
  RepertoireLoadingEvent({
    required this.date,
  });

  @override
  List<Object> get props => [];
}
