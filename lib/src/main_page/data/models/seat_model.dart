import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

part 'seat_model.g.dart';

@JsonSerializable()
class SeatModel extends SeatEntity {
  const SeatModel({
    required super.id,
    required super.price,
    required super.row,
    required super.seat,
    required super.discountId,
    required super.discountName,
    required super.status,
    required super.zoneId,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SeatModelToJson(this);
}
