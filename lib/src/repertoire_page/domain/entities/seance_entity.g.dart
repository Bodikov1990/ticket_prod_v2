// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeanceEntity _$SeanceEntityFromJson(Map<String, dynamic> json) => SeanceEntity(
      id: json['id'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      hall: json['hall'] == null
          ? null
          : HallEntity.fromJson(json['hall'] as Map<String, dynamic>),
      language: json['language'] as String?,
      isExistBuy: json['is_exist_buy'] as bool?,
    );

Map<String, dynamic> _$SeanceEntityToJson(SeanceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'duration': instance.duration,
      'hall': instance.hall,
      'language': instance.language,
      'is_exist_buy': instance.isExistBuy,
    };
