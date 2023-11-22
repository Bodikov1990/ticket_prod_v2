import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

part 'activate_entity.g.dart';

@JsonSerializable()
class ActivateEntity extends Equatable {
  final List<SeatEntity> seats;
  final String comment;

  const ActivateEntity({required this.seats, required this.comment});

  @override
  List<Object?> get props => [seats, comment];

  factory ActivateEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateEntityToJson(this);
}
