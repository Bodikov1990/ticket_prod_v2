import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_prod_v2/src/authentication/domain/usecases/authenticate_usecase.dart';
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
  }

  Future<void> _getUserHandler(
      SettingsGetUserEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsGettingUserState());

    final result = await _getUserUseCase();

    result.fold((failure) => null, (user) => userModel = user);
    if (userModel.baseURL != null && userModel.baseURL != '') {
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
    final result = await _authenticateUseCase(AuthenticateUseCaseParams(
        login: userModel.login, password: userModel.password));
    result.fold((failre) => null, (token) => userModel.accessToken = token);

    await _saveUserUseCase(SaveUserUseCaseParams(user: userModel));
    if (userModel.accessToken != null) {
      emit(SettingsSavedUserState());
    }
  }
}
