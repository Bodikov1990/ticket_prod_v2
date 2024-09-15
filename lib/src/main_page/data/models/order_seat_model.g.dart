// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSeatModel _$OrderSeatModelFromJson(Map<String, dynamic> json) =>
    OrderSeatModel(
      id: json['id'] as String?,
      zoneId: json['zone_id'] as String?,
      price: (json['price'] as num?)?.toInt(),
      row: json['row'] as String?,
      col: json['col'] as String?,
      discountId: json['discount_id'] as String?,
      discountName: json['discount_name'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderSeatModelToJson(OrderSeatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'zone_id': instance.zoneId,
      'price': instance.price,
      'row': instance.row,
      'col': instance.col,
      'discount_id': instance.discountId,
      'discount_name': instance.discountName,
      'status': instance.status,
    };
