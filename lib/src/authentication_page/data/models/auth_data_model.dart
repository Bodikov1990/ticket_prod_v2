import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/authentication_page/domain/entities/auth_data_entity.dart';

part 'auth_data_model.g.dart';

@JsonSerializable()
class AuthDataModel extends AuthDataEntity {
  AuthDataModel({required super.accessToken, required super.expiredAt});

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);
}
