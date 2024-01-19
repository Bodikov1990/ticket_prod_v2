part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsGettingUserState extends SettingsState {}

final class SettingsGetUserSuccessState extends SettingsState {
  final UserModel userModel;

  const SettingsGetUserSuccessState(this.userModel);

  @override
  List<Object> get props => [userModel];
}

final class SettingsSavedUserState extends SettingsState {
  final String login;
  final String password;
  final String baseURL;

  const SettingsSavedUserState(
      {required this.login, required this.password, required this.baseURL});

  @override
  List<Object> get props => [login, password, baseURL];
}

final class SettingsGetUserErrorState extends SettingsState {}

final class SettingsAuthenticatedState extends SettingsState {
  final String token;

  const SettingsAuthenticatedState(this.token);

  @override
  List<Object> get props => [token];
}

final class SettingsAuthenticateErrorState extends SettingsState {
  final String title;
  final String message;

  const SettingsAuthenticateErrorState(this.title, this.message);

  @override
  List<Object> get props => [title, message];
}
