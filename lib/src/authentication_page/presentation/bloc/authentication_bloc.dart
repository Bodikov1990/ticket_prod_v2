import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ticket_prod_v2/src/authentication_page/domain/usecases/authenticate_usecase.dart';
import 'package:ticket_prod_v2/src/authentication_page/domain/usecases/check_ping_usecase.dart';
import 'package:ticket_prod_v2/src/settings/data/models/settings_model.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SettingsRepository _settingsRepository = SettingsRepository();
  final ChecPingUseCase _checPingUseCase = ChecPingUseCase();
  final AuthenticateUseCase _authenticateUseCase = AuthenticateUseCase();

  UserModel userModel = UserModel();

  AuthenticationBloc() : super(const AuthenticationInitial()) {
    on<CheckPingEvent>(_checkPingHandler);
    on<CheckAuthenticationEvent>(_checkAuthHandler);
    on<SaveAuthenticationDataEvent>(_saveSettings);
  }

  Future<void> _checkPingHandler(
      CheckPingEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CheckPingState());
    final settings = await _settingsRepository.getSettings();

    String? baseURL = settings.ipAddress;

    if (baseURL != null) {
      final result =
          await _checPingUseCase(CheckPingUseCaseParams(baseURL: baseURL));

      result.fold(
          (failure) =>
              emit(AuthErrorState(failure.message, failure.statusCode)),
          (r) => emit(const CheckedPingSuccesState()));
    }
  }

  Future<void> _checkAuthHandler(
      CheckAuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CheckAuthenticationState());

    final settings = await _settingsRepository.getSettings();
    final String? login = settings.login;
    final String? password = settings.password;

    if ((login?.isNotEmpty ?? false) && (password?.isNotEmpty ?? false)) {
      final result = await _authenticateUseCase(
          AuthenticateUseCaseParams(login: login, password: password));
      result.fold(
          (failure) =>
              emit(AuthErrorState(failure.message, failure.statusCode)),
          (authData) => emit(CheckedAuthenticationState(
              accessToken: authData?.accessToken,
              expiredAt: authData?.expiredAt)));
    }
  }

  Future<void> _saveSettings(SaveAuthenticationDataEvent event,
      Emitter<AuthenticationState> emit) async {
    SettingsModel settings = await _settingsRepository.getSettings();
    String? accessToken = event.accessToken;
    String? expiredAt = event.expiredAt;

    if (accessToken != null && accessToken.isNotEmpty) {
      settings.accessToken = accessToken;
      settings.expiredAt = expiredAt;

      settings = await _settingsRepository.saveSettings(settings);
      emit(const AuthenticatedState());
    }
  }
}
