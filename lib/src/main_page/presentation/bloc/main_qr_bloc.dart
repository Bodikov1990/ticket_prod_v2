import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/usecases/get_rezervation_usecase.dart';

part 'main_qr_event.dart';
part 'main_qr_state.dart';

class MainQrBloc extends Bloc<MainQrEvent, MainQrState> {
  final GetRezervationUseCase _getRezervationUseCase = GetRezervationUseCase();

  MainQrBloc() : super(MainQrInitial()) {
    on<MainQrGetRezervationEvent>(_getRezervationHandler);
  }

  Future<void> _getRezervationHandler(
      MainQrGetRezervationEvent event, Emitter<MainQrState> emit) async {
    final result =
        await _getRezervationUseCase(GetRezervationUseCaseParams(id: event.id));
    TicketEntity? ticketEntity;
    result.fold(
        (failure) =>
            emit(MainQrGetRezervationErrorState(message: failure.message)),
        (ticket) => ticketEntity = ticket);
    if (ticketEntity?.status == 0 ||
        ticketEntity?.status == 1 ||
        ticketEntity?.status == 4 ||
        ticketEntity?.status == 5) {
      emit(MainQrGetRezervationErrorState(
          message: "Билет отправлен на возврат. Спасибо за обращение!"));
    } else {
      if (ticketEntity != null) {
        emit(MainQrGetRezervationSuccesState(
            ticket: ticketEntity ?? const TicketEntity()));
      }
    }
  }
}
