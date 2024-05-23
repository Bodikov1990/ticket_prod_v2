// ignore_for_file: constant_identifier_names, library_private_types_in_public_api
import 'dart:io' show Platform;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';

import 'package:ticket_prod_v2/injections/di.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ticket_prod_v2/core/viewmodels/theme_view_model.dart';
import 'package:ticket_prod_v2/injections/providers.dart';
import 'package:ticket_prod_v2/main_app_bloc/main_app_bloc.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/settings/repository/settings_repository.dart';

enum Environment {
  TEST,
  PRODUCTION,
  TEST_UA,
  PRODUCTION_UA,
}

const DEFAULT_ENV = Environment.PRODUCTION;

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isMacOS && !Platform.isWindows && !kIsWeb) {
    cameras = await availableCameras();
  }

  runApp(
    const RestartWidget(
      child: MultiProvider(child: ScannerApp()),
    ),
  );
}

class ScannerApp extends StatefulWidget {
  const ScannerApp({super.key});

  @override
  State<ScannerApp> createState() => _ScannerAppState();
}

class _ScannerAppState extends State<ScannerApp> {
  final _appRouter = GetIt.instance<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainAppBloc, MainAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp.router(
            key: ValueKey(state.locale),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            routerConfig: _appRouter.config(
                navigatorObservers: () =>
                    [TalkerRouteObserver(GetIt.I<Talker>())]),
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,
            theme: ThemeData(
              fontFamily: "Open Sans",
              primaryColor: ThemeViewModel().mainBlue,
              canvasColor: ThemeViewModel().canvasColor,
              primarySwatch: ThemeViewModel().mainBlue,
              appBarTheme: ThemeViewModel().appBarTheme,
              textTheme: ThemeViewModel().textTheme,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: ThemeViewModel().bottomBarBackgroundColor,
                  selectedItemColor: ThemeViewModel().accentColor,
                  unselectedItemColor: ThemeViewModel().grayColor),
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

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  final SettingsRepository _settingsRepository = SettingsRepository();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadEnv();
  }

  Future<bool> _loadEnv() async {
    await di.init(await _settingsRepository.getEnv() ?? DEFAULT_ENV);
    setState(() {
      loading = false;
    });
    return true;
  }

  void restartApp() async {
    await GetIt.instance.reset();
    await _loadEnv();
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: loading ? Container() : widget.child,
    );
  }
}
