import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_seat_entity.dart';

part 'order_seat_model.g.dart';

@JsonSerializable()
class OrderSeatModel extends OrderSeatEntity {
  const OrderSeatModel({
    required super.id,
    required super.zoneId,
    required super.price,
    required super.row,
    required super.col,
    required super.discountId,
    required super.discountName,
    required super.status,
  });

  factory OrderSeatModel.fromJson(Map<String, dynamic> json) =>
      _$OrderSeatModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderSeatModelToJson(this);
}
