import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ticket_prod_v2/src/authentication/domain/usecases/authenticate_usecase.dart';
import 'package:ticket_prod_v2/src/authentication/domain/usecases/check_ping_usecase.dart';
import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/get_user_usecase.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/save_user_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ChecPingUseCase _checPingUseCase = ChecPingUseCase();
  final AuthenticateUseCase _authenticateUseCase = AuthenticateUseCase();
  final GetUserUseCase _getUserUseCase = GetUserUseCase();
  final SaveUserUseCase _saveUserUseCase = SaveUserUseCase();
  UserModel userModel = UserModel();

  AuthenticationBloc() : super(const AuthenticationInitial()) {
    on<CheckPingEvent>(_checkPingHandler);
    on<CheckAuthenticationEvent>(_checkAuthHandler);
    on<AuthenticateEvent>(_authenticateHandler);
  }

  Future<void> _checkPingHandler(
      CheckPingEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CheckPingState());

    final result = await _getUserUseCase();
    result.fold(
        (failure) =>
            emit(AuthenticationErrorState(failure.message, failure.statusCode)),
        (user) => userModel = user);
    print(userModel.baseURL);
    print(userModel.login);
    print(userModel.password);
    print(userModel.accessToken);

    String? baseURL = userModel.baseURL;

    if (baseURL != null) {
      final result =
          await _checPingUseCase(CheckPingUseCaseParams(baseURL: baseURL));

      result.fold(
          (failure) =>
              emit(CheckedPingErrorState(failure.message, failure.statusCode)),
          (r) => emit(const CheckedPingSuccesState()));
    }
  }

  Future<void> _checkAuthHandler(
      CheckAuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CheckAuthenticationState());

    final user = await _getUserUseCase();

    user.fold(
        (failure) => emit(
            const CheckedAuthenticationErrorState(login: "", password: "")),
        (userModel) => emit(CheckedAuthenticationState(userModel)));
  }

  Future<void> _authenticateHandler(
      AuthenticateEvent event, Emitter<AuthenticationState> emit) async {
    final result = await _authenticateUseCase(AuthenticateUseCaseParams(
        login: event.login, password: event.password));

    result.fold(
        (failure) =>
            emit(AuthenticationErrorState(failure.message, failure.statusCode)),
        (token) => userModel.accessToken = token);

    await _saveUserUseCase(SaveUserUseCaseParams(user: userModel));
    if (userModel.accessToken != null) {
      emit(const AuthenticatedState());
    }
  }
}
