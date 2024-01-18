import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/schedule_entity.dart';

abstract class RepertoireRemoteDataSource {
  Future<List<ScheduleEntity>> getSchedule({required String date});
}

class RepertoireRemoteDataSourceImpl implements RepertoireRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();

  @override
  Future<List<ScheduleEntity>> getSchedule({required String date}) async {
    try {
      Response response = await _dio.get(
        '/api/schedule?date_from=$date&sort=movie.created_at:desc&sort=seance.timeframe.start:asc&skip=0&limit=0',
      );

      if (response.statusCode != 200) {
        throw APIExeption(
            message: response.statusMessage ?? "Exception from repo",
            statusCode: response.statusCode ?? 0);
      }

      return (response.data['data'] as List<dynamic>)
          .map((raw) => ScheduleEntity.fromJson(raw))
          .toList();
    } on APIExeption {
      rethrow;
    } catch (e) {
      debugPrint("getSchedule ${e.toString()} ");
      if (e is DioException) {
        debugPrint("${e.message} ${e.response?.statusMessage ?? ""}");

        throw APIExeption(
            message: e.message ?? "Opps",
            statusCode: e.response?.statusCode ?? 506);
      }
      throw APIExeption(message: e.toString(), statusCode: 507);
    }
  }
}
