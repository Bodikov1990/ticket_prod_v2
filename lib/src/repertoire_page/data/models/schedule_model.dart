import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  const ScheduleModel(
      {required super.id,
      required super.name,
      required super.duration,
      required super.certification,
      required super.seances});
}
