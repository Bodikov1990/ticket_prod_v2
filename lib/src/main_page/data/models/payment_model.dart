import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/payment_entity.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel extends PaymentEntity {
  const PaymentModel({super.id, super.name, super.type});
  @override
  List<Object?> get props => [id, name, type];

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
