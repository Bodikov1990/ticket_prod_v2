import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/presentaion/bloc/rezervation_number_bloc.dart';

@RoutePage()
class RezervationNumberScreen extends StatefulWidget {
  const RezervationNumberScreen({super.key});

  @override
  State<RezervationNumberScreen> createState() =>
      _RezervationNumberScreenState();
}

class _RezervationNumberScreenState extends State<RezervationNumberScreen> {
  final TextEditingController _reservationNumber = TextEditingController();
  final _rezrvationBloc = RezervationNumberBloc();
  bool isEnabledBtn = true;
  int _titleTapCount = 0;

  @override
  void initState() {
    super.initState();
    _rezrvationBloc.add(RezervationGetUserEvent());
    _reservationNumber.addListener(() {
      final inputString = _reservationNumber.text;

      final firstTwoDigits =
          inputString.length >= 2 ? inputString.substring(0, 2) : '';

      checkPrefixValidity(firstTwoDigits, inputString);
    });
  }

  void checkPrefixValidity(String prefix, String allDigits) async {
    if (allDigits.length >= 8) {
      setState(() {
        isEnabledBtn = true;
      });
    } else {
      setState(() {
        isEnabledBtn = false;
      });
    }
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TalkerScreen(talker: GetIt.I<Talker>())));
                  _titleTapCount = 0;
                }
              });
            },
            child: const Text(
              'Номер брони',
              style: TextStyle(color: Colors.white),
            )),
        centerTitle: true,
      ),
      body: BlocConsumer<RezervationNumberBloc, RezervationNumberState>(
        bloc: _rezrvationBloc,
        listener: (context, state) {
          if (state is RezervationGetTicketErrorState) {
            _showAlert(title: state.title, content: state.message);
          } else if (state is RezervationGetUserSuccesState) {
            String? prefix = state.userModel.prefix;
            if (prefix != null) {
              _reservationNumber.text = prefix;
            }
          } else if (state is RezervationGetTicketSuccesState) {
            if (state.ticketEntity.status == 0 ||
                state.ticketEntity.status == 1 ||
                state.ticketEntity.status == 4 ||
                state.ticketEntity.status == 5) {
              _showAlert(
                  title: 'Ошибка',
                  content: 'Билет отправлен на возврат. Спасибо за обращение!');
            } else {
              AutoRouter.of(context).push(DetailsRoute(
                  ticket: state.ticketEntity,
                  onTapOk: (isBackTapped) {
                    if (isBackTapped) {
                      _rezrvationBloc.add(RezervationGetUserEvent());
                    }
                  }));
            }
          }
        },
        builder: (context, state) {
          if (state is RezervationNumberLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _reservationNumber,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          labelText: "Введите номер брони",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: isEnabledBtn
                          ? () {
                              final number = _reservationNumber.text;
                              _rezrvationBloc.add(RezervationGetNumberEvent(
                                  number: number.substring(2)));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          disabledForegroundColor:
                              const Color.fromARGB(255, 31, 44, 67)
                                  .withOpacity(0.38),
                          disabledBackgroundColor:
                              const Color.fromARGB(255, 31, 44, 67)
                                  .withOpacity(0.12)),
                      child: const Text("Проверить бронь"),
                    )
                  ],
                ),
              )),
              floatingActionButton: FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 31, 44, 67),
                onPressed: () {
                  AutoRouter.of(context).push(const TextRecognizerRoute());
                },
                child: const Icon(Icons.scanner),
              ),
            ),
          );
        },
      ),
    );
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
              _rezrvationBloc.add(RezervationGetUserEvent());
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
