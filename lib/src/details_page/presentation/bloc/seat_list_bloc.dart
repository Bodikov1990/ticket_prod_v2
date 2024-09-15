import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/src/details_page/domain/usecases/activate_usecase.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_seat_entity.dart';

part 'seat_list_event.dart';
part 'seat_list_state.dart';

class SeatListBloc extends Bloc<SeatListEvent, SeatListState> {
  late final ActivateUseCase _activateUseCase = ActivateUseCase();

  Map<String, List<OrderSeatEntity>> allMapSeats = {};
  Map<String, List<OrderSeatEntity>> soldMapSeats = {};
  Map<String, List<OrderSeatEntity>> temporaryStorage = {};
  List<OrderSeatEntity>? activatedSeats = [];

  SeatListBloc() : super(SeatListInitial()) {
    on<SeatFilterEvent>(_seatFilterEvent);
    on<SeatAddEvent>(_seatAddEvent);
    on<SeatRemoveEvent>(_seatRemoveEvent);
    on<SeatActivateEvent>(_seatActivateEvent);
    on<SeatClearEvent>(_clearSeatsMapEvent);
  }

  void _seatFilterEvent(SeatFilterEvent event, Emitter<SeatListState> emit) {
    _clearSeatsMap();
    GetIt.I<Talker>()
        .debug("---  _seatFilterEvent SeatListBloc ${event.seats.length}");
    List<OrderSeatEntity> soldSeats =
        event.seats.where((seat) => seat.status == 4).toList();
    GetIt.I<Talker>()
        .debug("--- Filtering seats, total seats: ${event.seats.length}");
    for (OrderSeatEntity seat in soldSeats) {
      soldMapSeats[seat.discountName ?? ''] = soldSeats
          .where((element) => element.discountName == seat.discountName)
          .toList();

      allMapSeats[seat.discountName ?? ''] = soldSeats
          .where((element) => element.discountName == seat.discountName)
          .toList();
    }

    GetIt.I<Talker>().debug(
        "--- Sold seats: ${soldMapSeats.length}, All seats: ${allMapSeats.length}");

    activatedSeats = event.seats.where((seat) => seat.status == 6).toList();

    GetIt.I<Talker>()
        .debug("--- SS_ACTIVATED seats: ${activatedSeats?.length ?? 0}");

    emit(SeatFilteredState(
        allMapSeats: allMapSeats,
        soldMapSeats: soldMapSeats,
        activatedSeats: activatedSeats ?? []));
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
            activatedSeats: activatedSeats ?? []));
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
            activatedSeats: activatedSeats ?? []));
      }
    }
  }

  Future<void> _seatActivateEvent(
      SeatActivateEvent event, Emitter<SeatListState> emit) async {
    GetIt.I<Talker>()
        .debug("--- Discount values ${soldMapSeats.values.length}");
    List<OrderSeatEntity> newSeats = [];
    for (final seats in soldMapSeats.values) {
      for (OrderSeatEntity seat in seats) {
        GetIt.I<Talker>()
            .debug("--- Discount ID ${seat.id} ${seat.discountId}");
        final seatEntity = OrderSeatEntity(
            id: seat.id,
            discountId: seat.discountId,
            zoneId: seat.zoneId,
            price: seat.price,
            row: seat.row,
            col: seat.col,
            discountName: seat.discountName,
            status: seat.status);
        newSeats.add(seatEntity);
      }
    }

    _clearSeatsMap();

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

  void _clearSeatsMapEvent(SeatClearEvent event, Emitter<SeatListState> emit) {
    _clearSeatsMap();
  }

  void _clearSeatsMap() {
    GetIt.I<Talker>().debug("--- Cleared");
    allMapSeats.clear();
    soldMapSeats.clear();
    activatedSeats?.clear();
    temporaryStorage.clear();
  }
}
