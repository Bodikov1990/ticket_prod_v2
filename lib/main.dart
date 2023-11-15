// ignore_for_file: constant_identifier_names
import 'dart:io' show Platform;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ticket_prod_v2/injections/di.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ticket_prod_v2/core/utils/i18n.dart';
import 'package:ticket_prod_v2/core/viewmodels/theme_view_model.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';

final supportedLocales = [
  const Locale('kk', 'KZ'),
  const Locale('ru', 'RU'),
  const Locale('uk', 'UK'),
  const Locale('en', ''),
];

enum Environment {
  QR,
  PRODUCTION,
}

const DEFAULT_ENV = Environment.QR;
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isMacOS && !Platform.isWindows && !kIsWeb) {
    cameras = await availableCameras();
  }

  await di.init(DEFAULT_ENV);
  runApp(const ScannerApp());
}

class ScannerApp extends StatefulWidget {
  const ScannerApp({super.key});

  @override
  State<ScannerApp> createState() => _ScannerAppState();
}

class _ScannerAppState extends State<ScannerApp> {
  final _appRouter = GetIt.instance<AppRouter>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp.router(
        title: 'Tessera',
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        routerConfig: _appRouter.config(),
        locale: const Locale('ru', ''),
        theme: ThemeData(
          fontFamily: "Open Sans",
          primaryColor: ThemeViewModel(false).mainRed,
          canvasColor: ThemeViewModel(false).canvasColor,
          primarySwatch: ThemeViewModel(false).mainRed,
          appBarTheme: ThemeViewModel(false).appBarTheme,
          textTheme: ThemeViewModel(false).textTheme,
          buttonTheme: const ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      );
    });
  }
}
