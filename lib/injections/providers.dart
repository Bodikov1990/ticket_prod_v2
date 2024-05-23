import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ticket_prod_v2/main_app_bloc/main_app_bloc.dart';
import 'package:ticket_prod_v2/src/authentication_page/presentation/bloc/authentication_bloc.dart';

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
        // BlocProvider(
        //   create: (context) => FilterBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => WeekDayBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => PopupMenuBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => NearSeancesBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => SeanceBloc(),
        // ),
      ],
      child: child,
    );
  }
}
