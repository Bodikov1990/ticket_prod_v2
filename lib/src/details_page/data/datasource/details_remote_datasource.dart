import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

abstract class DetailsRemoteDataSource {
  Future<void> activate(
      {required String ticketID, required List<SeatEntity> seats});
}

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();
  final SettingsRepository _repository = SettingsRepository();

  @override
  Future<void> activate(
      {required String ticketID, required List<SeatEntity> seats}) async {
    final settings = await _repository.getSettings();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${settings.accessToken}',
      'User-Agent': 'ios',
      'Content-Type': 'application/json'
    };
    _dio.options.headers = headers;

    List<Map> seatsMap = seats.map((seat) {
      return {
        "id": seat.id ?? '',
        'discount_id': seat.discountId ?? '',
        "zone_id": seat.zoneId ?? ''
      };
    }).toList();

    final String url = '/api/ticket/$ticketID/activate';
    final data = {"seats": seatsMap};
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
