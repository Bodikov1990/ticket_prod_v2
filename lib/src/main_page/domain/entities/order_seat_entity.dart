import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_seat_entity.g.dart';

@JsonSerializable()
class OrderSeatEntity extends Equatable {
  final String? id;
  @JsonKey(name: 'zone_id')
  final String? zoneId;
  final int? price;
  final String? row;
  final String? col;
  @JsonKey(name: 'discount_id')
  final String? discountId;
  @JsonKey(name: 'discount_name')
  final String? discountName;
  final int? status;

  const OrderSeatEntity({
    required this.id,
    required this.zoneId,
    required this.price,
    required this.row,
    required this.col,
    required this.discountId,
    required this.discountName,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [id, zoneId, price, row, col, discountId, discountName, status];

  factory OrderSeatEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderSeatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSeatEntityToJson(this);
}
