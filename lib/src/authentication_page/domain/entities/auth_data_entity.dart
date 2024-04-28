import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthDataEntity {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'expired_at')
  final String? expiredAt;

  AuthDataEntity({required this.accessToken, required this.expiredAt});
}
