// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      languageModel: json['languageModel'] == null
          ? null
          : LanguageModel.fromJson(
              json['languageModel'] as Map<String, dynamic>),
      ipAddress: json['ipAddress'] as String?,
      deviceId: json['deviceId'] as String?,
    )
      ..env = $enumDecodeNullable(_$EnvironmentEnumMap, json['env'])
      ..userName = json['userName'] as String?
      ..login = json['login'] as String?
      ..password = json['password'] as String?
      ..accessToken = json['accessToken'] as String?
      ..cashierId = json['cashierId'] as String?
      ..expiredAt = json['expiredAt'] as String?
      ..prefix = json['prefix'] as String?
      ..endTimeDuration = json['endTimeDuration'] as int?;

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'env': _$EnvironmentEnumMap[instance.env],
      'userName': instance.userName,
      'login': instance.login,
      'password': instance.password,
      'ipAddress': instance.ipAddress,
      'accessToken': instance.accessToken,
      'deviceId': instance.deviceId,
      'cashierId': instance.cashierId,
      'expiredAt': instance.expiredAt,
      'prefix': instance.prefix,
      'endTimeDuration': instance.endTimeDuration,
      'languageModel': instance.languageModel,
    };

const _$EnvironmentEnumMap = {
  Environment.TEST: 'TEST',
  Environment.PRODUCTION: 'PRODUCTION',
  Environment.TEST_UA: 'TEST_UA',
  Environment.PRODUCTION_UA: 'PRODUCTION_UA',
};
