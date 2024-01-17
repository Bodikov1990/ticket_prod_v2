import 'package:ticket_prod_v2/src/repertoire_page/data/models/seance_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/hall_entity.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  const ScheduleModel(
      {required super.id,
      required super.name,
      required super.duration,
      required super.certification,
      required super.seances});

  List<SeanceModel> toSeansModelList() {
    return seances
            ?.map((e) => SeanceModel(
                id: e.id ?? '',
                startTime: e.startTime ?? '',
                endTime: e.endTime ?? '',
                duration: e.duration ?? 0,
                hall: e.hall ?? const HallEntity(),
                language: e.language ?? '',
                isExistBuy: e.isExistBuy ?? false))
            .toList() ??
        [];
  }
}
