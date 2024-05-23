import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/main_page/data/models/ticket_model.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

abstract class RezervationNumberRemoteDataSource {
  Future<TicketEntity> getRezervationNumber(String number);
}

class RezervationNumberRemoteDataSourceImpl
    implements RezervationNumberRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();
  final SettingsRepository _repository = SettingsRepository();

  @override
  Future<TicketEntity> getRezervationNumber(String number) async {
    final settings = await _repository.getSettings();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${settings.accessToken}',
      'User-Agent': 'ios'
    };
    _dio.options.headers = headers;

    try {
      Response response = await _dio.get(
        '/api/ticket/$number/number',
      );

      if (response.statusCode != 200) {
        throw APIExeption(
            message: response.statusMessage ?? "Exception from repo",
            statusCode: response.statusCode ?? 0);
      }

      return TicketModel.fromJson(response.data);
    } on APIExeption {
      rethrow;
    } catch (e) {
      debugPrint("getRezervationNumber ${e.toString()} ");
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
