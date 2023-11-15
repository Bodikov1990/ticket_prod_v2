import 'package:auto_route/auto_route.dart';
import 'package:ticket_prod_v2/src/authentication/presentation/views/login_screen.dart';
import 'package:ticket_prod_v2/src/settings/presentation/views/settings_screen.dart';
import 'package:ticket_prod_v2/src/tabbar/presentation/views/tab_bar_screen.dart';

part 'auto_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: TabBarRoute.page),
      ];
}
