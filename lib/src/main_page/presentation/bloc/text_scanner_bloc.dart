import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';

import 'package:ticket_prod_v2/src/rezervation_number_page/domain/usecases/get_number_rezervation_usecase.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

part 'text_scanner_event.dart';
part 'text_scanner_state.dart';

class TextScannerBloc extends Bloc<TextScannerEvent, TextScannerState> {
  final SettingsRepository _settingsRepository = SettingsRepository();
  final GetNumberRezervationUseCase _getNumberRezervationUseCase =
      GetNumberRezervationUseCase();
  TextScannerBloc() : super(TextScannerInitial()) {
    on<TextScannerGetPrefixEvent>(_getPrefix);
    on<TextScannerGetNumberEvent>(_getRezervationNumber);
  }

  Future<void> _getPrefix(
      TextScannerGetPrefixEvent event, Emitter<TextScannerState> emit) async {
    final settings = await _settingsRepository.getSettings();
    final prefix = settings.prefix;
    if (prefix != null && (prefix.isNotEmpty)) {
      emit(TextScannerPrefixLoadedState(prefix: prefix));
    }
  }

  Future<void> _getRezervationNumber(
      TextScannerGetNumberEvent event, Emitter<TextScannerState> emit) async {
    debugPrint(event.number);

    final result = await _getNumberRezervationUseCase(
        GetNumberRezervationUseCaseParams(number: event.number));

    result.fold(
        (failure) => _showError(failure.message, failure.statusCode, emit),
        (ticketEntity) =>
            emit(TextScannerGetTicketSuccesState(ticketEntity: ticketEntity)));
  }

  void _showError(
      String message, int statusCode, Emitter<TextScannerState> emit) {
    if (statusCode == 404) {
      emit(TextScannerLoadingErrorState(
          title: S.current.error, message: S.current.reservation_not_found));
    }
  }
}
