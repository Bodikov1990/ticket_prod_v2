import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hall_entity.g.dart';

@JsonSerializable()
class HallEntity extends Equatable {
  final String? id;
  final String? name;
  const HallEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

  factory HallEntity.fromJson(Map<String, dynamic> json) =>
      _$HallEntityFromJson(json);
  Map<String, dynamic> toJson() => _$HallEntityToJson(this);
}
