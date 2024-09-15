// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_entity.g.dart';

@JsonSerializable()
class PaymentEntity extends Equatable {
  final String? id;
  final int? type;
  final String? name;

  const PaymentEntity({
    this.id,
    this.type,
    this.name,
  });

  PaymentEntity copyWith({
    String? id,
    int? type,
    String? name,
  }) =>
      PaymentEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [id, type, name];

  factory PaymentEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEntityToJson(this);
}
