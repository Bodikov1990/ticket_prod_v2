import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_entity.g.dart';

@JsonSerializable()
class SeatEntity extends Equatable {
  final String? id;
  final int? price;
  final String? row;
  final String? seat;
  final String? discountId;
  final String? discountName;
  final String? status;
  final String? zoneId;
  const SeatEntity({
    this.id,
    this.price,
    this.row,
    this.seat,
    this.discountId,
    this.discountName,
    this.status,
    this.zoneId,
  });

  @override
  List<Object?> get props =>
      [id, price, row, seat, discountId, discountName, status, zoneId];

  factory SeatEntity.fromJson(Map<String, dynamic> json) =>
      _$SeatEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SeatEntityToJson(this);
}
