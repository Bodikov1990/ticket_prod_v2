part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
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
  List<Object> get props => [login, password, baseURL, prefix];
}

class SettingsAuthenticateEvent extends SettingsEvent {
  final String login;
  final String password;
  final String baseURL;

  const SettingsAuthenticateEvent(this.login, this.password, this.baseURL);
  @override
  List<Object> get props => [login, password, baseURL];
}

class SettingsSaveTokenEvent extends SettingsEvent {
  final String token;

  const SettingsSaveTokenEvent(this.token);
  @override
  List<Object> get props => [token];
}
