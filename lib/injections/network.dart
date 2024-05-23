// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

const TIMEOUT = 20000;
final getIt = GetIt.instance;

class AppVersionInterceptor extends Interceptor {
  final String version;

  AppVersionInterceptor({required this.version});
}

Future<String?> _baseUrl() async {
  final SettingsRepository repository = SettingsRepository();
  final setting = await repository.getSettings();
  return setting.ipAddress;
}

Future<void> init() async {
  String? baseURL = await _baseUrl();

  // Register Dio
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseURL ?? '',
  ));
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
