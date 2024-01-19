import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/authentication_page/data/models/authentication_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> checkPing(String baseURL);
  Future<String?> authenticate(
      {required String? login, required String? password, String? baseURL});
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();

  @override
  Future<String?> authenticate({
    required String? login,
    required String? password,
    String? baseURL,
  }) async {
    AuthenticationModel authModel =
        AuthenticationModel(login: login, password: password);

    String url = baseURL ?? _dio.options.baseUrl;
    debugPrint("authenticate baseURL $url");

    try {
      Response response =
          await _dio.post('$url/api/auth/login', data: authModel.toJson());

      if (response.statusCode != 200) {
        throw APIExeption(
          message: response.statusMessage ?? "Exception from repo",
          statusCode: response.statusCode ?? 0,
        );
      }

      debugPrint(response.data["access_token"]);
      return response.data["access_token"];
    } catch (e) {
      debugPrint("authenticate ${e.toString()}");

      if (e is DioException) {
        debugPrint(
            "authenticate ${e.message} ${e.response?.statusMessage ?? ""}");
        int statusCode = e.response?.statusCode ?? 0;
        String message =
            e.response?.statusMessage ?? e.message ?? '_empty.error.message';

        throw APIExeption(message: message, statusCode: statusCode);
      }

      throw APIExeption(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<void> checkPing(String baseURL) async {
    try {
      Response response = await _dio.get(baseURL);
      if (response.statusCode != 200) {
        throw APIExeption(
            message: response.statusMessage ?? "Exception from repo",
            statusCode: response.statusCode ?? 0);
      }
    } on APIExeption {
      rethrow;
    } catch (e) {
      debugPrint("checkPing ${e.toString()} ");
      if (e is DioException) {
        debugPrint("${e.message} ${e.response?.statusMessage ?? ""}");

        throw APIExeption(
            message: e.message ?? "Opps",
            statusCode: e.response?.statusCode ?? 0);
      }
      throw APIExeption(message: e.toString(), statusCode: 0);
    }
  }
}
