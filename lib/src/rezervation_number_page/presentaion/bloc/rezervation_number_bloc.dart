import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/domain/usecases/get_number_rezervation_usecase.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

part 'rezervation_number_event.dart';
part 'rezervation_number_state.dart';

class RezervationNumberBloc
    extends Bloc<RezervationNumberEvent, RezervationNumberState> {
  final GetNumberRezervationUseCase _getNumberRezervationUseCase =
      GetNumberRezervationUseCase();
  final SettingsRepository _settingsRepository = SettingsRepository();

  RezervationNumberBloc() : super(RezervationNumberInitial()) {
    on<RezervationLoadingEvent>(_getUserEvent);
    on<RezervationGetNumberEvent>(_getNumberEvent);
  }

  Future<void> _getUserEvent(RezervationLoadingEvent event,
      Emitter<RezervationNumberState> emit) async {
    final settings = await _settingsRepository.getSettings();

    String? prefix = settings.prefix;

    if (prefix != null) {
      emit(RezervationGetUserSuccesState(prefix: prefix));
    }
  }

  Future<void> _getNumberEvent(RezervationGetNumberEvent event,
      Emitter<RezervationNumberState> emit) async {
    debugPrint(event.number);
    emit(RezervationNumberLoadingState());
    final result = await _getNumberRezervationUseCase(
        GetNumberRezervationUseCaseParams(number: event.number));

    result.fold(
        (failure) => _showError(failure.statusCode, emit),
        (ticketEntity) =>
            emit(RezervationGetTicketSuccesState(ticketEntity: ticketEntity)));
  }

  void _showError(int statusCode, Emitter<RezervationNumberState> emit) {
    if (statusCode == 404) {
      emit(RezervationGetTicketErrorState(
          title: S.current.error, message: S.current.reservation_not_found));
    }
  }
}
