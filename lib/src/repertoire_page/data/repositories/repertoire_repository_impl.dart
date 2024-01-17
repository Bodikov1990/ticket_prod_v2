import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/datasources/repertoire_remote_datasource.dart';
import 'package:ticket_prod_v2/src/repertoire_page/data/models/schedule_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/repository/repertoire_repository.dart';

class RepertoireRepositoryImpl implements RepertoireRepository {
  final RepertoireRemoteDataSource _dataSource =
      GetIt.instance<RepertoireRemoteDataSource>();

  @override
  ResultFuture<List<ScheduleModel>> getSchedule({required String data}) async {
    try {
      final result = await _dataSource.getSchedule(date: data);

      return Right(result
          .map((schedule) => ScheduleModel(
              id: schedule.id,
              name: schedule.name,
              duration: schedule.duration,
              certification: schedule.certification,
              seances: schedule.seances))
          .toList());
    } on APIExeption catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }
}
