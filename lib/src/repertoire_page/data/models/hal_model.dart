import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/hall_entity.dart';

class HallModel extends HallEntity {
  const HallModel({required String id, required String name})
      : super(id: id, name: name);

  HallModel toModel() {
    return HallModel(id: id ?? '', name: name ?? '');
  }
}
