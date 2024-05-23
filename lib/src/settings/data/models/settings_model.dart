import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/src/settings/data/models/language_model.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  Environment? env;
  String? userName;
  String? login;
  String? password;
  String? ipAddress;
  String? accessToken;
  String? deviceId;
  String? cashierId;
  String? expiredAt;
  String? prefix;
  int? endTimeDuration;
  LanguageModel? languageModel;

  SettingsModel({this.languageModel, this.ipAddress, this.deviceId}) {
    env = DEFAULT_ENV;
    endTimeDuration = 0;
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  factory SettingsModel.fromJsonString(String jsonString) =>
      SettingsModel.fromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  String toJsonString() => jsonEncode(toJson());
}
