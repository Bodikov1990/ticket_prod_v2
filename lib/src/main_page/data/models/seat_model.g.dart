// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) => SeatModel(
      id: json['id'] as String?,
      price: json['price'] as int?,
      row: json['row'] as String?,
      seat: json['seat'] as String?,
      discountId: json['discountId'] as String?,
      discountName: json['discountName'] as String?,
      status: json['status'] as String?,
      zoneId: json['zoneId'] as String?,
    );

Map<String, dynamic> _$SeatModelToJson(SeatModel instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'row': instance.row,
      'seat': instance.seat,
      'discountId': instance.discountId,
      'discountName': instance.discountName,
      'status': instance.status,
      'zoneId': instance.zoneId,
    };
