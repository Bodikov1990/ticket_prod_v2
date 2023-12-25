// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/hall_entity.dart';

part 'seance_entity.g.dart';

@JsonSerializable()
class SeanceEntity extends Equatable {
  final String? id;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  final int? duration;
  final HallEntity? hall;
  final String? language;
  @JsonKey(name: 'is_exist_buy')
  final bool? isExistBuy;
  const SeanceEntity({
    this.id,
    this.startTime,
    this.endTime,
    this.duration,
    this.hall,
    this.language,
    this.isExistBuy,
  });

  @override
  List<Object?> get props =>
      [id, startTime, endTime, duration, hall, language, isExistBuy];

  factory SeanceEntity.fromJson(Map<String, dynamic> json) =>
      _$SeanceEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SeanceEntityToJson(this);
}
