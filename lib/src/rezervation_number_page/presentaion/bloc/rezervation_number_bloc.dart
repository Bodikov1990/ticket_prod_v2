import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/domain/usecases/get_number_rezervation_usecase.dart';
import 'package:ticket_prod_v2/src/user/data/models/user_model.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/get_user_usecase.dart';

part 'rezervation_number_event.dart';
part 'rezervation_number_state.dart';

class RezervationNumberBloc
    extends Bloc<RezervationNumberEvent, RezervationNumberState> {
  GetUserUseCase getUserUseCase = GetUserUseCase();
  final GetNumberRezervationUseCase _getNumberRezervationUseCase =
      GetNumberRezervationUseCase();
  UserModel userModel = UserModel();

  RezervationNumberBloc() : super(RezervationNumberInitial()) {
    on<RezervationGetUserEvent>(_getUserEvent);
    on<RezervationGetNumberEvent>(_getNumberEvent);
  }

  Future<void> _getUserEvent(RezervationGetUserEvent event,
      Emitter<RezervationNumberState> emit) async {
    final result = await getUserUseCase();

    result.fold((failure) => null, (user) => userModel = user);

    String? prefix = userModel.prefix;

    if (prefix != null) {
      emit(RezervationGetUserSuccesState(userModel: userModel));
    }
  }

  Future<void> _getNumberEvent(RezervationGetNumberEvent event,
      Emitter<RezervationNumberState> emit) async {
    debugPrint(event.number);
    final result = await _getNumberRezervationUseCase(
        GetNumberRezervationUseCaseParams(number: event.number));

    result.fold(
        (failure) => _showError(failure.message, failure.statusCode, emit),
        (ticketEntity) =>
            emit(RezervationGetTicketSuccesState(ticketEntity: ticketEntity)));
  }

  void _showError(
      String message, int statusCode, Emitter<RezervationNumberState> emit) {
    if (statusCode == 404) {
      emit(const RezervationGetTicketErrorState(
          title: "Ошибка!",
          message:
              'Извините, бронь не найдена. Пожалуйста, проверьте введенный номер брони и попробуйте снова.'));
    }
  }
}
