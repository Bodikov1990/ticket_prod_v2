part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsGettingUserState extends SettingsState {}

final class SettingsGetErrorState extends SettingsState {}

final class SettingsGetUserSuccessState extends SettingsState {
  final SettingsModel settings;

  const SettingsGetUserSuccessState(this.settings);

  @override
  List<Object?> get props => [settings];
}

final class SettingsSavedState extends SettingsState {}

final class SettingsAuthenticatedState extends SettingsState {
  final String login;
  final String password;
  final String baseURL;
  final String prefix;
  final String? token;
  final String? expiredAt;

  const SettingsAuthenticatedState(
      {required this.login,
      required this.password,
      required this.baseURL,
      required this.prefix,
      required this.token,
      required this.expiredAt});

  @override
  List<Object?> get props =>
      [login, password, baseURL, prefix, token, expiredAt];
}

final class SettingsAuthErrorState extends SettingsState {
  final int stausCode;
  final String message;

  const SettingsAuthErrorState(this.stausCode, this.message);

  @override
  List<Object> get props => [stausCode, message];
}
