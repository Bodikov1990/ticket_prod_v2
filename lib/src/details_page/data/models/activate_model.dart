import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/details_page/domain/entities/activate_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

part 'activate_model.g.dart';

@JsonSerializable()
class ActivateModel extends ActivateEntity {
  const ActivateModel({required super.seats, required super.comment});

  factory ActivateModel.fromJson(Map<String, dynamic> json) =>
      _$ActivateModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActivateModelToJson(this);
}
