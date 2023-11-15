import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/src/authentication/data/models/authentication_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> checkPing(String baseURL);
  Future<String?> authenticate(
      {required String? login, required String? password});
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio _dio = GetIt.instance<Dio>();
  @override
  Future<String?> authenticate(
      {required String? login, required String? password}) async {
    AuthenticationModel authModel =
        AuthenticationModel(login: login, password: password);
    try {
      Response response =
          await _dio.post('/api/auth/login', data: authModel.toJson());
      if (response.statusCode != 200) {
        throw APIExeption(
            message: response.statusMessage ?? "Exception from repo",
            statusCode: response.statusCode ?? 0);
      }
      debugPrint(response.data["access_token"]);
      return response.data["access_token"];
    } on APIExeption {
      rethrow;
    } catch (e) {
      if (e is DioException) {
        throw APIExeption(
            message: e.message ?? "Opps",
            statusCode: e.response?.statusCode ?? 505);
      }
      throw APIExeption(message: e.toString(), statusCode: 505);
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
      throw APIExeption(message: e.toString(), statusCode: 505);
    }
  }
}
