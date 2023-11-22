// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as String?,
      number: json['number'] as String?,
      movie: json['movie'] as String?,
      seanceDate: json['seance_date'] as String?,
      hall: json['hall'] as String?,
      contract: json['contract'] as String?,
      status: json['status'] as int?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => SeatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'status': instance.status,
      'movie': instance.movie,
      'contract': instance.contract,
      'hall': instance.hall,
      'seance_date': instance.seanceDate,
      'seats': instance.seats,
    };
