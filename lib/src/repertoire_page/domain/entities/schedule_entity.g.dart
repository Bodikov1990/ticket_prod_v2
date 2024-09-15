// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleEntity _$ScheduleEntityFromJson(Map<String, dynamic> json) =>
    ScheduleEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      certification: json['certification'] as String?,
      seances: (json['seances'] as List<dynamic>?)
          ?.map((e) => SeanceEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleEntityToJson(ScheduleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duration': instance.duration,
      'certification': instance.certification,
      'seances': instance.seances,
    };
