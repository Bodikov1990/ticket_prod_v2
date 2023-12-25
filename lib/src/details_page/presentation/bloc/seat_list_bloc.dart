import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ticket_prod_v2/src/details_page/domain/entities/activate_entity.dart';
import 'package:ticket_prod_v2/src/details_page/domain/usecases/activate_usecase.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

part 'seat_list_event.dart';
part 'seat_list_state.dart';

class SeatListBloc extends Bloc<SeatListEvent, SeatListState> {
  late final ActivateUseCase _activateUseCase = ActivateUseCase();

  Map<String, List<SeatEntity>> allMapSeats = {};
  Map<String, List<SeatEntity>> soldMapSeats = {};
  Map<String, List<SeatEntity>> activatedMapSeats = {};
  Map<String, List<SeatEntity>> temporaryStorage = {};

  SeatListBloc() : super(SeatListInitial()) {
    on<SeatFilterEvent>(_seatFilterEvent);
    on<SeatAddEvent>(_seatAddEvent);
    on<SeatRemoveEvent>(_seatRemoveEvent);
    on<SeatActivateEvent>(_seatActivateEvent);
  }

  void _seatFilterEvent(SeatFilterEvent event, Emitter<SeatListState> emit) {
    List<SeatEntity> soldSeat =
        event.seats.where((seat) => seat.status == "SOLD").toList();
    debugPrint("--- Filtering seats, total seats: ${event.seats.length}");
    for (SeatEntity seat in soldSeat) {
      soldMapSeats[seat.discountName ?? ''] = soldSeat
          .where((element) => element.discountName == seat.discountName)
          .toList();

      allMapSeats[seat.discountName ?? ''] = soldSeat
          .where((element) => element.discountName == seat.discountName)
          .toList();
    }

    debugPrint(
        "--- Sold seats: ${soldMapSeats.length}, All seats: ${allMapSeats.length}");

    List<SeatEntity> activatedSeat =
        event.seats.where((seat) => seat.status == "SS_ACTIVATED").toList();

    for (SeatEntity seat in activatedSeat) {
      activatedMapSeats[seat.discountName ?? ''] = activatedSeat
          .where((element) => element.discountName == seat.discountName)
          .toList();
    }

    emit(SeatFilteredState(
        allMapSeats: allMapSeats,
        soldMapSeats: soldMapSeats,
        activatedMapSeats: activatedMapSeats));
  }

  void _seatAddEvent(SeatAddEvent event, Emitter<SeatListState> emit) {
    if (temporaryStorage.containsKey(event.discountName) &&
        temporaryStorage[event.discountName]?.isNotEmpty == true) {
      final seatToAdd = temporaryStorage[event.discountName]?.removeLast();

      if (seatToAdd != null) {
        soldMapSeats.putIfAbsent(event.discountName, () => []).add(seatToAdd);
        debugPrint("--- Seat added: ${seatToAdd.id} to ${event.discountName}");

        emit(SeatFilteredState(
            allMapSeats: allMapSeats,
            soldMapSeats: soldMapSeats,
            activatedMapSeats: activatedMapSeats));
      }
    }
  }

  void _seatRemoveEvent(SeatRemoveEvent event, Emitter<SeatListState> emit) {
    if (soldMapSeats.containsKey(event.discountName) &&
        soldMapSeats[event.discountName]?.isNotEmpty == true) {
      final seatToRemove = soldMapSeats[event.discountName]?.removeLast();
      if (seatToRemove != null) {
        temporaryStorage
            .putIfAbsent(event.discountName, () => [])
            .add(seatToRemove);
        debugPrint(
            "--- Seat removed: ${seatToRemove.id} from ${event.discountName}");

        emit(SeatFilteredState(
            allMapSeats: allMapSeats,
            soldMapSeats: soldMapSeats,
            activatedMapSeats: activatedMapSeats));
      }
    }
  }

  Future<void> _seatActivateEvent(
      SeatActivateEvent event, Emitter<SeatListState> emit) async {
    debugPrint("--- Discount values ${soldMapSeats.values.length}");
    List<SeatEntity> newSeats = [];
    for (final seats in soldMapSeats.values) {
      for (SeatEntity seat in seats) {
        debugPrint("--- Discount ID ${seat.id} ${seat.discountId}");
        final seatEntity = SeatEntity(id: seat.id, discountId: seat.discountId);
        newSeats.add(seatEntity);
      }
    }

    final activateEntity = ActivateEntity(seats: newSeats, comment: "");
    debugPrint(
        "--- Activating seats: ${newSeats.length}, Ticket ID: ${event.ticketID}");
    final result = await _activateUseCase(ActivateUseCaseParams(
        ticketID: event.ticketID, activateEntity: activateEntity));

    int statusCode = 0;
    result.fold(
        (failure) => statusCode = failure.statusCode,
        (r) => emit(SeatActivatedState(
            title: "Успешно!",
            message: "Поздравляем! Ваша бронь успешно активирована. ")));

    debugPrint("--- Activating status code: $statusCode");
    if (statusCode == 410) {
      emit(SeatActivateErrorState(
          title: "Ошибка",
          message:
              "Извините, время активации доступно за 30 минут до начала сеанса. Пожалуйста, попробуйте позже."));
    } else {
      emit(SeatActivateErrorState(
          title: "Ошибка!", message: "Неизвестная ошибка!"));
    }
  }
}
