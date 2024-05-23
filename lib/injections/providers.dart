import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ticket_prod_v2/main_app_bloc/main_app_bloc.dart';
import 'package:ticket_prod_v2/src/authentication_page/presentation/bloc/authentication_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/details_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/seat_list_bloc.dart';
import 'package:ticket_prod_v2/src/main_page/presentation/bloc/text_scanner_bloc.dart';
import 'package:ticket_prod_v2/src/repertoire_page/presentation/bloc/repertoire_bloc.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/presentaion/bloc/rezervation_number_bloc.dart';
import 'package:ticket_prod_v2/src/settings/presentation/bloc/settings_bloc.dart';

class MultiProvider extends StatelessWidget {
  final Widget child;
  const MultiProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainAppBloc()..add(MainGetSavedLocaleEvent()),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider(
          create: (context) => DetailsBloc(),
        ),
        BlocProvider(
          create: (context) => SeatListBloc(),
        ),
        BlocProvider(
          create: (context) => TextScannerBloc(),
        ),
        BlocProvider(
          create: (context) => RepertoireBloc(),
        ),
        BlocProvider(
          create: (context) => RezervationNumberBloc(),
        ),
      ],
      child: child,
    );
  }
}
