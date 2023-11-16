// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketEntity _$TicketEntityFromJson(Map<String, dynamic> json) => TicketEntity(
      id: json['id'] as String?,
      number: json['number'] as String?,
      status: json['status'] as int?,
      movie: json['movie'] as String?,
      contract: json['contract'] as String?,
      hall: json['hall'] as String?,
      seanceDate: json['seanceDate'] as String?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => SeatEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketEntityToJson(TicketEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'status': instance.status,
      'movie': instance.movie,
      'contract': instance.contract,
      'hall': instance.hall,
      'seanceDate': instance.seanceDate,
      'seats': instance.seats,
    };
