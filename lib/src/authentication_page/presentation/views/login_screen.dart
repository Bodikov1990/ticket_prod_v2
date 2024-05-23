import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
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

  AuthenticationBloc? _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context, listen: false);
    _authenticationBloc?.add(CheckPingEvent());
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
          listener: (context, state) {
            if (state is AuthErrorState) {
              _showErrorByStatusCode(state.statusCode, state.message);
            } else if (state is CheckedPingSuccesState) {
              _authenticationBloc?.add(const CheckAuthenticationEvent());
            } else if (state is CheckedAuthenticationState) {
              _authenticationBloc?.add(SaveAuthenticationDataEvent(
                  accessToken: state.accessToken, expiredAt: state.expiredAt));
            } else if (state is AuthenticatedState) {
              AutoRouter.of(context).replace(const TabBarRoute());
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  void _showErrorByStatusCode(int statusCode, String message) {
    if (statusCode == 401) {
      _showAlert(
          title: S.current.auth_login_error,
          content: S.current.user_validation_password);
    } else if (statusCode == 404) {
      _showAlert(
          title: S.current.auth_login_error,
          content: S.current.users_not_found_error);
    } else if (statusCode == 400) {
      _showAlert(
          title: S.current.auth_login_error,
          content: S.current.user_validation_password);
    } else if (statusCode == 0) {
      _showAlert(
          title: S.current.no_connection,
          content: S.current.please_check_connection);
    } else if (message == 'The connection errored') {
      _showAlert(
          title: S.current.no_connection,
          content: S.current.please_check_connection);
    } else {
      _showAlert(title: S.current.unknown_error, content: message);
    }
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
