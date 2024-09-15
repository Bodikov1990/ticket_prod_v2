// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String?,
      number: json['number'] as String?,
      cashier: json['cashier'] as String?,
      status: (json['status'] as num?)?.toInt(),
      movie: json['movie'] as String?,
      contract: json['contract'] as String?,
      hall: json['hall'] as String?,
      seanceDate: json['seance_date'] as String?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => OrderSeatEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      payment: json['payment'] == null
          ? null
          : PaymentEntity.fromJson(json['payment'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      qrcode: json['qrcode'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'cashier': instance.cashier,
      'status': instance.status,
      'movie': instance.movie,
      'contract': instance.contract,
      'hall': instance.hall,
      'seance_date': instance.seanceDate,
      'seats': instance.seats,
      'payment': instance.payment,
      'qrcode': instance.qrcode,
      'created_at': instance.createdAt,
    };
