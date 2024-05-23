// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsGetUserEvent extends SettingsEvent {}

class SettingsSaveUserEvent extends SettingsEvent {
  final String login;
  final String password;
  final String baseURL;
  final String prefix;

  const SettingsSaveUserEvent(
      {required this.login,
      required this.password,
      required this.baseURL,
      required this.prefix});

  @override
  List<Object?> get props => [login, password, baseURL, prefix];
}

class SettingsSaveTokenEvent extends SettingsEvent {
  final String login;
  final String password;
  final String baseURL;
  final String prefix;
  final String? token;
  final String? expiredAt;
  const SettingsSaveTokenEvent(
      {required this.login,
      required this.password,
      required this.baseURL,
      required this.prefix,
      required this.token,
      required this.expiredAt});

  @override
  List<Object?> get props => [login, password, baseURL, prefix, token];
}
