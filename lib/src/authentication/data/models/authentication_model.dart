import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/src/authentication/domain/entities/authentication_entity.dart';

part 'authentication_model.g.dart';

@JsonSerializable()
class AuthenticationModel extends AuthenticationEntity {
  AuthenticationModel({required super.login, required super.password});

  AuthenticationModel.empty()
      : this(login: "_empty.login", password: "_empty.password");

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);
}
