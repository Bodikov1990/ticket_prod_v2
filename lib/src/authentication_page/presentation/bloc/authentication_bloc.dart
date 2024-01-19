import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_prod_v2/src/authentication_page/domain/usecases/authenticate_usecase.dart';
import 'package:ticket_prod_v2/src/authentication_page/domain/usecases/check_ping_usecase.dart';

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
        (failure) => _showError(failure.statusCode, failure.message, emit),
        (user) => userModel = user);

    String? baseURL = userModel.baseURL;

    if (baseURL != null) {
      final result =
          await _checPingUseCase(CheckPingUseCaseParams(baseURL: baseURL));

      result.fold(
          (failure) => _showError(failure.statusCode, failure.message, emit),
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
        (failure) => _showError(failure.statusCode, failure.message, emit),
        (token) => userModel.accessToken = token);

    await _saveUserUseCase(SaveUserUseCaseParams(user: userModel));
    if (userModel.accessToken != null) {
      emit(const AuthenticatedState());
    }
  }

  void _showError(
      int statusCode, String message, Emitter<AuthenticationState> emit) {
    if (statusCode == 401) {
      emit(const AuthenticationErrorState("Ошибка!", 'Неверный пароль'));
    } else if (statusCode == 404) {
      emit(const AuthenticationErrorState("Ошибка!", 'Неверный логин'));
    } else if (message == 'The connection errored') {
      emit(const AuthenticationErrorState("Нет связи с сервером!",
          'Пожалуйста проверьте правильно ли заполнили адрес сервера!'));
    } else {
      emit(const CheckedPingErrorState("Нет связи с сервером!",
          'Пожалуйста проверьте правильно ли заполнили адрес сервера!'));
    }
  }
}
