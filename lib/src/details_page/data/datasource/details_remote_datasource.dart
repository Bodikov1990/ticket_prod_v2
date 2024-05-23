import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/details_page/data/models/activate_model.dart';
import 'package:ticket_prod_v2/src/details_page/domain/entities/activate_entity.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

abstract class DetailsRemoteDataSource {
  Future<void> activate(
      {required String ticketID, required ActivateEntity activateEntity});
}

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();
  final SettingsRepository _repository = SettingsRepository();

  @override
  Future<void> activate(
      {required String ticketID,
      required ActivateEntity activateEntity}) async {
    final settings = await _repository.getSettings();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${settings.accessToken}',
      'User-Agent': 'ios',
      'Content-Type': 'application/json'
    };
    _dio.options.headers = headers;

    final String url = '/api/ticket/$ticketID/activate';
    final data = ActivateModel(
            seats: activateEntity.seats, comment: activateEntity.comment)
        .toJson();
    try {
      Response response = await _dio.put(url, data: data);

      if (response.statusCode != 200) {
        throw APIExeption(
            message: response.statusMessage ??
                "Exception from DetailsRemoteDataSource",
            statusCode: response.statusCode ?? 0);
      }
    } on APIExeption {
      rethrow;
    } catch (e) {
      debugPrint("activate ${e.toString()} ");
      if (e is DioException) {
        debugPrint("activate ${e.message} ${e.response?.statusMessage ?? ""}");
        throw APIExeption(
            message: e.message ?? '', statusCode: e.response?.statusCode ?? 0);
      }
      throw APIExeption(message: e.toString(), statusCode: 507);
    }
  }
}
