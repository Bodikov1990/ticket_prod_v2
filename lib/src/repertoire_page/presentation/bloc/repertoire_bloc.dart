// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/models/schedule_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/seance_info_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/usecases/get_schedule_usecase.dart';

part 'repertoire_event.dart';
part 'repertoire_state.dart';

const int STATUS_UPCOMING = 0;
const int STATUS_STARTING_SOON = 1;
const int STATUS_IN_PROGRESS = 2;

// Bloc for managing Repertoire State
class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  final GetScheduleUseCase _getScheduleUseCase = GetScheduleUseCase();

  RepertoireBloc() : super(RepertoireInitial()) {
    on<RepertoireLoadingEvent>(_onLoadingEvent);
  }

  // Handler for Loading Event
  Future<void> _onLoadingEvent(
      RepertoireLoadingEvent event, Emitter<RepertoireState> emit) async {
    if (state is! RepertoireLoadedState) {
      emit(RepertoireLoadingState());
    }

    final scheduleResult =
        await _getScheduleUseCase(GetScheduleUseCaseParams(date: event.date));
    scheduleResult.fold(
      (failure) => emit(RepertoireLoadedErrorState(
          message: failure.message, statusCode: failure.statusCode)),
      (schedule) => _processScheduleData(schedule, emit),
    );
  }

  // Process schedule data and emit state
  void _processScheduleData(
      List<ScheduleModel> schedule, Emitter<RepertoireState> emit) {
    List<SeanceInfoModel> seances = _convertToSeanceInfoModels(schedule);
    _removePastSeances(seances);
    seances.sort((a, b) => a.startTime.compareTo(b.startTime));
    emit(RepertoireLoadedState(seances: seances));
  }

  // Convert ScheduleModel to a list of SeanceInfoModel
  List<SeanceInfoModel> _convertToSeanceInfoModels(
      List<ScheduleModel> schedule) {
    DateTime now = DateTime.now();
    return schedule.expand((movie) {
      return movie.toSeansModelList().map((seance) {
        int seanceStatus = _determineSeanceStatus(
            seance.startTimeFromSource, seance.endTimeFromSource, now);
        return SeanceInfoModel(
            id: seance.id ?? '',
            movie: movie.name ?? '',
            startTime: seance.startTimeFromSource,
            endTime: seance.endTimeFromSource,
            hallName: seance.toHallModel().name ?? '',
            seanceStatus: seanceStatus,
            isExistBuy: seance.isExistBuy ?? false);
      });
    }).toList();
  }

  // Remove seances that have already ended
  void _removePastSeances(List<SeanceInfoModel> seances) {
    DateTime now = DateTime.now();
    seances.removeWhere((seance) => seance.endTime.isBefore(now));
  }

  // Determine the status of the seance
  int _determineSeanceStatus(
      DateTime startTime, DateTime endTime, DateTime now) {
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      // Seance has already started but not ended
      return STATUS_IN_PROGRESS;
    } else if (now.add(const Duration(minutes: 30)).isAfter(startTime)) {
      // Seance is going to start in the next 30 minutes
      return STATUS_STARTING_SOON;
    } else {
      // Seance has not started yet
      return STATUS_UPCOMING;
    }
  }
}
