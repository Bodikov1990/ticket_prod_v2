import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

part 'ticket_entity.g.dart';

@JsonSerializable()
class TicketEntity extends Equatable {
  final String? id;
  final String? number;
  final int? status;
  final String? movie;
  final String? contract;
  final String? hall;
  @JsonKey(name: "seance_date")
  final String? seanceDate;
  final List<SeatEntity>? seats;

  const TicketEntity({
    this.id,
    this.number,
    this.status,
    this.movie,
    this.contract,
    this.hall,
    this.seanceDate,
    this.seats,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        status,
        movie,
        contract,
        hall,
        seanceDate,
        seats?.map((e) => e.id).toList()
      ];

  factory TicketEntity.fromJson(Map<String, dynamic> json) =>
      _$TicketEntityFromJson(json);
  Map<String, dynamic> toJson() => _$TicketEntityToJson(this);
}
