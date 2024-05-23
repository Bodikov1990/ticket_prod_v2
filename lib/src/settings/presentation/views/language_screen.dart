import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_prod_v2/main_app_bloc/main_app_bloc.dart';
import 'package:ticket_prod_v2/src/settings/data/models/language_model.dart';

@RoutePage()
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var groupValue = context.read<MainAppBloc>().state.locale.languageCode;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<MainAppBloc, MainAppState>(
        listener: (context, state) {
          groupValue = state.locale.languageCode;
        },
        builder: (context, state) {
          return ListView.builder(
              itemCount: languageModelList.length,
              itemBuilder: (context, index) {
                var item = languageModelList[index];
                return RadioListTile(
                    value: item.languageCode,
                    groupValue: groupValue,
                    title: Text(item.language),
                    subtitle: Text(item.subLanguage),
                    onChanged: (value) {
                      BlocProvider.of<MainAppBloc>(context).add(
                          MainChangeLocaleEvent(Locale(item.languageCode)));
                    });
              });
        },
      ),
    );
  }
}
