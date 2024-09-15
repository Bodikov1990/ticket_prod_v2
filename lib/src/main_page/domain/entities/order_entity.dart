import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_seat_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/payment_entity.dart';

part 'order_entity.g.dart';

@JsonSerializable()
class OrderEntity extends Equatable {
  final String? id;
  final String? number;
  final String? cashier;
  final int? status;
  final String? movie;
  final String? contract;
  final String? hall;
  @JsonKey(name: 'seance_date')
  final String? seanceDate;
  final List<OrderSeatEntity>? seats;
  final PaymentEntity? payment;
  final String? qrcode;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  const OrderEntity({
    this.id,
    this.number,
    this.cashier,
    this.status,
    this.movie,
    this.contract,
    this.hall,
    this.seanceDate,
    this.seats,
    this.payment,
    this.qrcode,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        cashier,
        status,
        movie,
        contract,
        hall,
        seanceDate,
        seats,
        payment,
        qrcode,
        createdAt,
      ];

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);
}
