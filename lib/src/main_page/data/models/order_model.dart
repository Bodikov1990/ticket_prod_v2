import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_seat_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/payment_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.number,
    required super.cashier,
    required super.status,
    required super.movie,
    required super.contract,
    required super.hall,
    required super.seanceDate,
    required super.seats,
    required super.payment,
    required super.createdAt,
    required super.qrcode,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
