part of 'repertoire_bloc.dart';

sealed class RepertoireState extends Equatable {
  const RepertoireState();
  
  @override
  List<Object> get props => [];
}

final class RepertoireInitial extends RepertoireState {}
