import 'package:ticket_prod_v2/src/repertoire_page/data/models/hal_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/hall_entity.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/seance_entity.dart';

class SeanceModel extends SeanceEntity {
  const SeanceModel(
      {required String id,
      required String startTime,
      required String endTime,
      required int duration,
      required HallEntity hall,
      required String language,
      required bool isExistBuy})
      : super(
            id: id,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            hall: hall,
            language: language,
            isExistBuy: isExistBuy);

  DateTime get startTimeFromSource {
    try {
      if (startTime == null) {
        return DateTime.fromMicrosecondsSinceEpoch(0);
      } else {
        return DateTime.parse(startTime?.substring(0, 19) ?? '');
      }
    } catch (ignored) {
      return DateTime.fromMicrosecondsSinceEpoch(0);
    }
  }

  DateTime get endTimeFromSource {
    try {
      if (endTime == null) {
        return DateTime.fromMicrosecondsSinceEpoch(0);
      } else {
        return DateTime.parse(endTime?.substring(0, 19) ?? '');
      }
    } catch (ignored) {
      return DateTime.fromMicrosecondsSinceEpoch(0);
    }
  }

  HallModel toHallModel() {
    return HallModel(id: hall?.id ?? '', name: hall?.name ?? '');
  }
}
