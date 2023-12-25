// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/seance_entity.dart';

part 'schedule_entity.g.dart';

@JsonSerializable()
class ScheduleEntity extends Equatable {
  final String? id;
  final String? name;
  final int? duration;
  final String? certification;
  final List<SeanceEntity>? seances;

  const ScheduleEntity({
    this.id,
    this.name,
    this.duration,
    this.certification,
    this.seances,
  });

  @override
  List<Object?> get props =>
      [id, name, duration, certification, seances?.map((e) => e.id).toList()];

  factory ScheduleEntity.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleEntityToJson(this);
}
