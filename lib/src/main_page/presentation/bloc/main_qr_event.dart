// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_qr_bloc.dart';

abstract class MainQrEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MainQrGetRezervationEvent extends MainQrEvent {
  final String id;
  MainQrGetRezervationEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
