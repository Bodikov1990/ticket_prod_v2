import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
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
    List<SeatEntity> soldSeats =
        event.seats.where((seat) => seat.status == "SOLD").toList();
    GetIt.I<Talker>()
        .debug("--- Filtering seats, total seats: ${event.seats.length}");
    for (SeatEntity seat in soldSeats) {
      soldMapSeats[seat.discountName ?? ''] = soldSeats
          .where((element) => element.discountName == seat.discountName)
          .toList();

      allMapSeats[seat.discountName ?? ''] = soldSeats
          .where((element) => element.discountName == seat.discountName)
          .toList();
    }

    GetIt.I<Talker>().debug(
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
        GetIt.I<Talker>()
            .debug("--- Seat added: ${seatToAdd.id} to ${event.discountName}");

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
        GetIt.I<Talker>().debug(
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
    GetIt.I<Talker>()
        .debug("--- Discount values ${soldMapSeats.values.length}");
    List<SeatEntity> newSeats = [];
    for (final seats in soldMapSeats.values) {
      for (SeatEntity seat in seats) {
        GetIt.I<Talker>()
            .debug("--- Discount ID ${seat.id} ${seat.discountId}");
        final seatEntity = SeatEntity(
            id: seat.id, discountId: seat.discountId, zoneId: seat.zoneId);
        newSeats.add(seatEntity);
      }
    }

    GetIt.I<Talker>().debug(
        "--- Activating seats: ${newSeats.length}, Ticket ID: ${event.ticketID}");
    emit(SeatListActivatingState());
    final result = await _activateUseCase(
        ActivateUseCaseParams(ticketID: event.ticketID, seats: newSeats));

    int? statusCode;
    result.fold(
        (failure) => statusCode = failure.statusCode,
        (r) => emit(SeatActivatedState(
            title: S.current.success,
            message: S.current.congratulation_activate)));

    GetIt.I<Talker>().debug("--- Activating status code: $statusCode");
    if (statusCode == 410) {
      emit(SeatActivateErrorState(
          title: S.current.error, message: S.current.sorry_dont_activated));
    } else if (statusCode == 400) {
      emit(SeatActivateErrorState(
          title: S.current.error, message: S.current.sorry_empty_activate));
    }
  }
}
