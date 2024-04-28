// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/get_user_usecase.dart';

const TIMEOUT = 60000;
final getIt = GetIt.instance;

class AppVersionInterceptor extends Interceptor {
  final String version;

  AppVersionInterceptor({required this.version});
}

Future<String> _apiToken() async {
  GetUserUseCase getUserUseCase = GetUserUseCase();
  String? token = '';
  final result = await getUserUseCase();
  result.fold((l) => null, (user) => token = user.accessToken);

  return token ?? '';
}

Future<String?> _baseUrl() async {
  GetUserUseCase getUserUseCase = GetUserUseCase();
  String? baseURL = '';
  final result = await getUserUseCase();
  result.fold((l) => null, (user) => baseURL = user.baseURL);

  return baseURL;
}

void init() async {
  String? baseURL = await _baseUrl();
  String? accessToken = await _apiToken();
  final Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};

  // Register Dio
  final Dio dio = Dio(BaseOptions(baseUrl: baseURL ?? '', headers: headers));
  dio.interceptors.add(TalkerDioLogger(
      talker: GetIt.I<Talker>(),
      settings: const TalkerDioLoggerSettings(
          printRequestData: true,
          printResponseData: true,
          printResponseMessage: true,
          printRequestHeaders: true,
          printResponseHeaders: false)));
  getIt.registerLazySingleton<Dio>(() => dio);
}
