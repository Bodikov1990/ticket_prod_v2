import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/authentication_page/presentation/bloc/authentication_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _titleTapCount = 0;

  final _authenticationBloc = AuthenticationBloc();

  @override
  void initState() {
    super.initState();
    _authenticationBloc.add(CheckPingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _titleTapCount++;
                  if (_titleTapCount == 20) {
                    AutoRouter.of(context).push(const SettingsRoute());
                    _titleTapCount = 0;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset('assets/images/logo_tessera_white.png'),
              )),
          centerTitle: true,
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: _authenticationBloc,
          listener: (context, state) {
            if (state is CheckedPingErrorState) {
              _showAlert(title: state.title, content: state.message);
            } else if (state is AuthenticationErrorState) {
              _showAlert(title: state.title, content: state.message);
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (context, state) {
              if (state is CheckPingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CheckedPingSuccesState) {
                _authenticationBloc.add(const CheckAuthenticationEvent());
              } else if (state is CheckedAuthenticationState) {
                String? login = state.user.login;
                String? password = state.user.password;
                String? expiredAt = state.user.expiredAt;
                if (login != null && password != null && expiredAt != null) {
                  _authenticationBloc.add(AuthenticateEvent(
                      login: login, password: password, expiredAt: expiredAt));
                }
              } else if (state is AuthenticatedState) {
                AutoRouter.of(context).replace(const TabBarRoute());
              }
              return Container();
            },
          ),
        ));
  }

  _showAlert({String? title, String? content}) {
    final content0 = content ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(title, style: const TextStyle(fontWeight: FontWeight.w600))
            : null,
        content: Text(content0),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Ок',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
