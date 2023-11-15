import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_prod_v2/main.dart';

import './network.dart' as network;
import './repositories.dart' as repositories;

final getIt = GetIt.instance;

Future<void> init(Environment env) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  repositories.init(env);
  network.init(env);
}
