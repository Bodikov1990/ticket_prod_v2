import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/seance_entity.dart';

class SeanceModel extends SeanceEntity {
  const SeanceModel(
      {required super.id,
      required super.startTime,
      required super.endTime,
      required super.duration,
      required super.hall,
      required super.language,
      required super.isExistBuy});

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
}
