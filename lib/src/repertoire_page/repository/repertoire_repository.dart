import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/models/schedule_model.dart';

abstract class RepertoireRepository {
  ResultFuture<List<ScheduleModel>> getSchedule({required String data});
}
