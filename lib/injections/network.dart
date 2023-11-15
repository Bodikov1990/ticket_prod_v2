// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/src/user/domain/usecases/get_user_usecase.dart';

const TIMEOUT = 60000;
final getIt = GetIt.instance;

class AppVersionInterceptor extends Interceptor {
  final String version;

  AppVersionInterceptor({required this.version});

  // @override
  // void onRequest(
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   options.headers.putIfAbsent("Accept", () => "application/json; $version");
  //   options.headers
  //       .putIfAbsent("Platform", () => Platform.isAndroid ? "Android" : "iOS");
  //   handler.next(options);
  // }
}

Future<String> _apiToken(Environment env) async {
  switch (env) {
    case Environment.QR:
      GetUserUseCase getUserUseCase = GetUserUseCase();
      String? token = '';
      final result = await getUserUseCase();
      result.fold((l) => null, (user) => token = user.accessToken);
      return token ?? '';
    case Environment.PRODUCTION:
      return "ec40d076-d3e6-4b20-b7ec-8d02a90858dc";
    default:
      throw Exception("WRONG API TYPE");
  }
}

Future<String?> _baseUrl(Environment env) async {
  switch (env) {
    case Environment.QR:
      GetUserUseCase getUserUseCase = GetUserUseCase();
      String? baseURL = '';
      final result = await getUserUseCase();
      result.fold((l) => null, (user) => baseURL = user.baseURL);
      return baseURL;
    case Environment.PRODUCTION:
      return "https://afisha.api.kinopark.kz";
    default:
      throw Exception("WRONG API TYPE");
  }
}

void init(Environment env) async {
  String? baseURL = await _baseUrl(env);
  String? accessToken = await _apiToken(env);
  final Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};

  // Register Dio
  final Dio dio = Dio(BaseOptions(baseUrl: baseURL ?? '', headers: headers));
  getIt.registerLazySingleton<Dio>(() => dio);
}
