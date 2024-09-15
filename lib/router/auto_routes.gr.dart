// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_routes.dart';

/// generated route for
/// [DetailsScreen]
class DetailsRoute extends PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    Key? key,
    required TicketEntity ticket,
    required void Function(bool) onTapActivate,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            key: key,
            ticket: ticket,
            onTapActivate: onTapActivate,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailsRouteArgs>();
      return DetailsScreen(
        key: args.key,
        ticket: args.ticket,
        onTapActivate: args.onTapActivate,
      );
    },
  );
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.ticket,
    required this.onTapActivate,
  });

  final Key? key;

  final TicketEntity ticket;

  final void Function(bool) onTapActivate;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, ticket: $ticket, onTapActivate: $onTapActivate}';
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LanguageScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QRScannerScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RepertoireRouteArgs>(
          orElse: () => const RepertoireRouteArgs());
      return RepertoireScreen(
        key: args.key,
        date: args.date,
      );
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RezervationNumberScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TabBarPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TextRecognizerScreen();
    },
  );
}
