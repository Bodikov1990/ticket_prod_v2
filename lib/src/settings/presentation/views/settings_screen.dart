import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/settings/presentation/bloc/settings_bloc.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settingsBloc = SettingsBloc();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _settingsBloc.add(SettingsGetUserEvent());
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
    _settingsBloc.add(SettingsSaveUserEvent(
        baseURL: _addressController.text,
        prefix: _prefixController.text,
        login: _usernameController.text,
        password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        bloc: _settingsBloc,
        listener: (context, state) {
          if (state is SettingsGetUserSuccessState) {
            _initAddressController(
                state.userModel.baseURL,
                state.userModel.prefix,
                state.userModel.login,
                state.userModel.password);
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
                  textField(_usernameController, "Username"),
                  const SizedBox(height: 16.0),
                  textField(_passwordController, "Password"),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      _setAPI();
                      AutoRouter.of(context).replace(const TabBarRoute());
                    },
                    child: const Text('Update settings'),
                  ),
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
}
