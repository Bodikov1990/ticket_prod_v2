// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'repertoire_bloc.dart';

abstract class RepertoireState extends Equatable {}

final class RepertoireInitial extends RepertoireState {
  @override
  List<Object?> get props => [];
}

final class RepertoireLoadingState extends RepertoireState {
  @override
  List<Object?> get props => [];
}

class RepertoireLoadedState extends RepertoireState {
  final List<SeanceInfoModel> seances;
  RepertoireLoadedState({
    required this.seances,
  });

  @override
  List<Object> get props => [seances];
}

class RepertoireLoadedErrorState extends RepertoireState {
  final String message;
  final int statusCode;
  RepertoireLoadedErrorState({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}
