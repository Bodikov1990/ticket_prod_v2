import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/main.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';

import 'package:ticket_prod_v2/src/settings/presentation/bloc/settings_bloc.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _titleTapCount = 0;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsBloc>(context).add(SettingsGetUserEvent());
  }

  @override
  void dispose() {
    _addressController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _prefixController.dispose();
    super.dispose();
  }

  void _initAddressController(
      String? baseURL, String? prefix, String? login, String? password) {
    _addressController.text = baseURL ?? 'http://';
    _prefixController.text = prefix ?? '';
    _usernameController.text = login ?? '';
    _passwordController.text = password ?? '';
  }

  void _setAPI() async {
    BlocProvider.of<SettingsBloc>(context).add(SettingsSaveUserEvent(
        baseURL: _addressController.text,
        prefix: _prefixController.text,
        login: _usernameController.text,
        password: _passwordController.text));
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
                AutoRouter.of(context).push(const LanguageRoute());
                _titleTapCount = 0;
              }
            });
          },
          child: Text(
            S.current.settings,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsGetUserSuccessState) {
            _initAddressController(
              state.settings.ipAddress,
              state.settings.prefix,
              state.settings.login,
              state.settings.password,
            );
          } else if (state is SettingsAuthenticatedState) {
            BlocProvider.of<SettingsBloc>(context).add(
              SettingsSaveTokenEvent(
                  login: state.login,
                  password: state.password,
                  baseURL: state.baseURL,
                  prefix: state.prefix,
                  token: state.token,
                  expiredAt: state.expiredAt),
            );
          } else if (state is SettingsSavedState) {
            RestartWidget.restartApp(context);
          } else if (state is SettingsAuthErrorState) {
            _showErrorByStatusCode(state.stausCode, state.message);
          } else if (state is SettingsGetErrorState) {
            _addressController.text = 'http://';
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textField(_addressController, "Base URL"),
                  const SizedBox(height: 16.0),
                  textField(_prefixController, "Prefix"),
                  const SizedBox(height: 16.0),
                  textField(_usernameController, S.current.enter_username),
                  const SizedBox(height: 16.0),
                  textField(_passwordController, S.current.password),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      _setAPI();
                    },
                    child: Text(S.current.save),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TalkerScreen(talker: GetIt.I<Talker>())));
                      },
                      child: Text(S.current.show_log))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextField textField(TextEditingController? controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
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
