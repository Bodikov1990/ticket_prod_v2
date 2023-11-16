import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/data/models/seat_model.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel extends TicketEntity {
  const TicketModel(
      {required super.id,
      required super.number,
      required super.movie,
      required super.seanceDate,
      required super.hall,
      required super.contract,
      required super.status,
      required List<SeatModel>? seats})
      : super(seats: seats);

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
