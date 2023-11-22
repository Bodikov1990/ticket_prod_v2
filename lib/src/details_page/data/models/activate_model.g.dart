// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateModel _$ActivateModelFromJson(Map<String, dynamic> json) =>
    ActivateModel(
      seats: (json['seats'] as List<dynamic>)
          .map((e) => SeatEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$ActivateModelToJson(ActivateModel instance) =>
    <String, dynamic>{
      'seats': instance.seats,
      'comment': instance.comment,
    };
