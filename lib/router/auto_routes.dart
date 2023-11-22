import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ticket_prod_v2/src/authentication_page/presentation/views/login_screen.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/views/details_sreen.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';
import 'package:ticket_prod_v2/src/main_page/presentation/views/main_screen.dart';
import 'package:ticket_prod_v2/src/main_page/presentation/views/vision_detector_views/qr_scanner_screen.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/presentaion/views/rezervation_number_screen.dart';
import 'package:ticket_prod_v2/src/settings/presentation/views/settings_screen.dart';
import 'package:ticket_prod_v2/src/tabbar/presentation/views/tab_bar_screen.dart';

part 'auto_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: QRScannerRoute.page),
        AutoRoute(page: DetailsRoute.page),
        AutoRoute(page: TabBarRoute.page, path: '/tab-bar', children: [
          AutoRoute(page: MainRoute.page, path: 'tab1'),
          AutoRoute(page: RezervationNumberRoute.page, path: 'tab2'),
        ]),
      ];
}
