import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/main_page/data/models/order_model.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

abstract class MainQRRemoteDataSource {
  Future<OrderModel> getRezervation(String id);
}

class MainQRRemoteDataSourceImpl implements MainQRRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();
  final SettingsRepository _repository = SettingsRepository();

  @override
  Future<OrderModel> getRezervation(String id) async {
    final settings = await _repository.getSettings();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${settings.accessToken}',
      'User-Agent': 'ios'
    };
    _dio.options.headers = headers;
    try {
      Response response = await _dio.get(
        '/api/ticket/$id',
      );

      if (response.statusCode != 200) {
        throw APIExeption(
            message: response.statusMessage ?? "Exception from repo",
            statusCode: response.statusCode ?? 0);
      }

      return OrderModel.fromJson(response.data);
    } on APIExeption {
      rethrow;
    } catch (e) {
      debugPrint("getRezervation ${e.toString()} ");
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
