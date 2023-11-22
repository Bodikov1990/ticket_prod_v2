// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activate_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateEntity _$ActivateEntityFromJson(Map<String, dynamic> json) =>
    ActivateEntity(
      seats: (json['seats'] as List<dynamic>)
          .map((e) => SeatEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$ActivateEntityToJson(ActivateEntity instance) =>
    <String, dynamic>{
      'seats': instance.seats,
      'comment': instance.comment,
    };
