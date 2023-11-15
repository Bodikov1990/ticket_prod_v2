part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
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

final class SettingsGetUserErrorState extends SettingsState {}

final class SettingsAuthenticatedState extends SettingsState {}
