// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) => SeatModel(
      id: json['id'] as String?,
      price: (json['price'] as num?)?.toInt(),
      row: json['row'] as String?,
      seat: json['seat'] as String?,
      discountId: json['discount_id'] as String?,
      discountName: json['discount_name'] as String?,
      status: json['status'] as String?,
      zoneId: json['zone_id'] as String?,
    );

Map<String, dynamic> _$SeatModelToJson(SeatModel instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'row': instance.row,
      'seat': instance.seat,
      'discount_id': instance.discountId,
      'discount_name': instance.discountName,
      'status': instance.status,
      'zone_id': instance.zoneId,
    };
