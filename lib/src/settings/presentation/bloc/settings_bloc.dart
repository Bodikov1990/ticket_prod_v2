import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ticket_prod_v2/src/authentication_page/domain/usecases/authenticate_usecase.dart';

import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/get_user_usecase.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/save_user_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetUserUseCase _getUserUseCase = GetUserUseCase();
  final SaveUserUseCase _saveUserUseCase = SaveUserUseCase();
  final AuthenticateUseCase _authenticateUseCase = AuthenticateUseCase();
  UserModel userModel = UserModel();

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsGetUserEvent>(_getUserHandler);
    on<SettingsSaveUserEvent>(_saveUserHandler);
    on<SettingsSaveTokenEvent>(_saveTokenHandler);
    on<SettingsAuthenticateEvent>(_authenticateHandler);
  }

  Future<void> _getUserHandler(
      SettingsGetUserEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsGettingUserState());

    final result = await _getUserUseCase();

    result.fold((failure) => null, (user) => userModel = user);
    String? baseURL = userModel.baseURL;
    if (baseURL != null && baseURL != '') {
      emit(SettingsGetUserSuccessState(userModel));
    } else {
      emit(SettingsGetUserErrorState());
    }
  }

  Future<void> _saveUserHandler(
      SettingsSaveUserEvent event, Emitter<SettingsState> emit) async {
    userModel.baseURL = event.baseURL;
    userModel.prefix = event.prefix;
    userModel.login = event.login;
    userModel.password = event.password;

    final result =
        await _saveUserUseCase(SaveUserUseCaseParams(user: userModel));
    result.fold((failure) => null, (r) => null);
    String? login = userModel.login;
    String? password = userModel.password;
    String? baseURL = userModel.baseURL;
    if (login != null && password != null && baseURL != null) {
      emit(SettingsSavedUserState(
          login: login, password: password, baseURL: baseURL));
    }
  }

  _authenticateHandler(
      SettingsAuthenticateEvent event, Emitter<SettingsState> emit) async {
    final result = await _authenticateUseCase(AuthenticateUseCaseParams(
        login: event.login, password: event.password, baseURL: event.baseURL));
    String? localToken = '';
    result.fold(
        (failure) => emit(SettingsAuthenticateErrorState(
            failure.message, failure.statusCode.toString())),
        (token) => localToken = token);
    debugPrint("SettingsBloc $localToken ");
    if (localToken != null && localToken != '') {
      emit(SettingsAuthenticatedState(localToken!));
    }
  }

  Future<void> _saveTokenHandler(
      SettingsSaveTokenEvent event, Emitter<SettingsState> emit) async {
    userModel.accessToken = event.token;
    await _saveUserUseCase(SaveUserUseCaseParams(user: userModel));
  }
}
