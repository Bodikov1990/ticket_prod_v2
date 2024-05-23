import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ticket_prod_v2/src/authentication_page/domain/usecases/authenticate_usecase.dart';
import 'package:ticket_prod_v2/src/settings/data/models/settings_model.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository = SettingsRepository();
  final AuthenticateUseCase _authenticateUseCase = AuthenticateUseCase();

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsGetUserEvent>(_getUserHandler);
    on<SettingsSaveUserEvent>(_saveUserHandler);
    on<SettingsSaveTokenEvent>(_saveTokenHandler);
  }

  Future<void> _getUserHandler(
      SettingsGetUserEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsGettingUserState());
    final settings = await _settingsRepository.getSettings();

    final String? baseURL = settings.ipAddress;
    if (baseURL != null && baseURL != '') {
      emit(SettingsGetUserSuccessState(settings));
    } else {
      emit(SettingsGetErrorState());
    }
  }

  Future<void> _saveUserHandler(
      SettingsSaveUserEvent event, Emitter<SettingsState> emit) async {
    final result = await _authenticateUseCase(AuthenticateUseCaseParams(
        login: event.login, password: event.password, baseURL: event.baseURL));

    result.fold(
        (failure) =>
            emit(SettingsAuthErrorState(failure.statusCode, failure.message)),
        (authData) => emit(SettingsAuthenticatedState(
              login: event.login,
              password: event.password,
              baseURL: event.baseURL,
              prefix: event.prefix,
              token: authData?.accessToken,
              expiredAt: authData?.expiredAt,
            )));
  }

  Future<void> _saveTokenHandler(
      SettingsSaveTokenEvent event, Emitter<SettingsState> emit) async {
    final settings = await _settingsRepository.getSettings();

    settings.ipAddress = event.baseURL;
    settings.prefix = event.prefix;
    settings.login = event.login;
    settings.password = event.password;
    settings.accessToken = event.token;
    settings.expiredAt = event.expiredAt;
    await _settingsRepository.saveSettings(settings);
    emit(SettingsSavedState());
  }
}
