// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsScreen(
          key: args.key,
          ticket: args.ticket,
          onTapOk: args.onTapOk,
        ),
      );
    },
    LanguageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguageScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    QRScannerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QRScannerScreen(),
      );
    },
    RepertoireRoute.name: (routeData) {
      final args = routeData.argsAs<RepertoireRouteArgs>(
          orElse: () => const RepertoireRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RepertoireScreen(
          key: args.key,
          date: args.date,
        ),
      );
    },
    RezervationNumberRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RezervationNumberScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TabBarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TabBarPage(),
      );
    },
    TextRecognizerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TextRecognizerScreen(),
      );
    },
  };
}

/// generated route for
/// [DetailsScreen]
class DetailsRoute extends PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    Key? key,
    required TicketEntity ticket,
    required void Function(bool) onTapOk,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            key: key,
            ticket: ticket,
            onTapOk: onTapOk,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static const PageInfo<DetailsRouteArgs> page =
      PageInfo<DetailsRouteArgs>(name);
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.ticket,
    required this.onTapOk,
  });

  final Key? key;

  final TicketEntity ticket;

  final void Function(bool) onTapOk;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, ticket: $ticket, onTapOk: $onTapOk}';
  }
}

/// generated route for
/// [LanguageScreen]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
      : super(
          LanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QRScannerScreen]
class QRScannerRoute extends PageRouteInfo<void> {
  const QRScannerRoute({List<PageRouteInfo>? children})
      : super(
          QRScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'QRScannerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RepertoireScreen]
class RepertoireRoute extends PageRouteInfo<RepertoireRouteArgs> {
  RepertoireRoute({
    Key? key,
    DateTime? date,
    List<PageRouteInfo>? children,
  }) : super(
          RepertoireRoute.name,
          args: RepertoireRouteArgs(
            key: key,
            date: date,
          ),
          initialChildren: children,
        );

  static const String name = 'RepertoireRoute';

  static const PageInfo<RepertoireRouteArgs> page =
      PageInfo<RepertoireRouteArgs>(name);
}

class RepertoireRouteArgs {
  const RepertoireRouteArgs({
    this.key,
    this.date,
  });

  final Key? key;

  final DateTime? date;

  @override
  String toString() {
    return 'RepertoireRouteArgs{key: $key, date: $date}';
  }
}

/// generated route for
/// [RezervationNumberScreen]
class RezervationNumberRoute extends PageRouteInfo<void> {
  const RezervationNumberRoute({List<PageRouteInfo>? children})
      : super(
          RezervationNumberRoute.name,
          initialChildren: children,
        );

  static const String name = 'RezervationNumberRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TabBarPage]
class TabBarRoute extends PageRouteInfo<void> {
  const TabBarRoute({List<PageRouteInfo>? children})
      : super(
          TabBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabBarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TextRecognizerScreen]
class TextRecognizerRoute extends PageRouteInfo<void> {
  const TextRecognizerRoute({List<PageRouteInfo>? children})
      : super(
          TextRecognizerRoute.name,
          initialChildren: children,
        );

  static const String name = 'TextRecognizerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
