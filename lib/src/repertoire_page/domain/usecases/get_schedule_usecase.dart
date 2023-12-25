// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/usecase/usecase.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/models/schedule_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/repository/repertoire_repository.dart';

class GetScheduleUseCase
    extends UsecaseWithParams<List<ScheduleModel>, GetScheduleUseCaseParams> {
  final RepertoireRepository _repository =
      GetIt.instance<RepertoireRepository>();
  @override
  ResultFuture<List<ScheduleModel>> call(
          GetScheduleUseCaseParams params) async =>
      _repository.getSchedule(data: params.data);
}

class GetScheduleUseCaseParams {
  final String data;
  GetScheduleUseCaseParams({
    required this.data,
  });
}
