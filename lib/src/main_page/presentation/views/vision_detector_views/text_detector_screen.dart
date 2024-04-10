import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/main_page/presentation/bloc/text_scanner_bloc.dart';

import 'camera_view.dart';

@RoutePage()
class TextRecognizerScreen extends StatefulWidget {
  const TextRecognizerScreen({super.key});

  @override
  State<TextRecognizerScreen> createState() => _TextRecognizerScreenState();
}

class _TextRecognizerScreenState extends State<TextRecognizerScreen> {
  final _textScannerBloc = TextScannerBloc();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void initState() {
    super.initState();
    _textScannerBloc.add(TextScannerGetPrefixEvent());
  }

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> processImage(InputImage inputImage, String prefix) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    setState(() {
      _text = '';
    });

    final recognizedText = await _textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          final String? reservationNumber = processString(element.text, prefix);

          if (reservationNumber != null) {
            GetIt.I<Talker>().debug(reservationNumber);
            _textScannerBloc
                .add(TextScannerGetNumberEvent(number: reservationNumber));
          }
        }
      }
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  String? processString(String inputString, String prefix) {
    if (inputString.length >= 8 && prefix != '_empty.prefix') {
      String firstTwoDigits = inputString.substring(0, 2);

      if (firstTwoDigits == prefix) {
        _canProcess = false;
        _textRecognizer.close();
        return inputString.substring(2);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextScannerBloc, TextScannerState>(
      bloc: _textScannerBloc,
      listener: (context, state) {
        if (state is TextScannerLoadingErrorState) {
          _showAlert(title: state.title, content: state.message);
        } else if (state is TextScannerGetTicketSuccesState) {
          if (state.ticketEntity.status == 0 ||
              state.ticketEntity.status == 1 ||
              state.ticketEntity.status == 4 ||
              state.ticketEntity.status == 5) {
            _showAlert(
                title: 'Помилка',
                content:
                    'Квиток відправлено на повернення. Дякуємо за звернення!');
          } else {
            AutoRouter.of(context).push(DetailsRoute(
                ticket: state.ticketEntity,
                onTapOk: (isBackTapped) {
                  if (isBackTapped) {
                    _textScannerBloc.add(TextScannerGetPrefixEvent());
                  }
                }));
          }
        }
      },
      builder: (context, state) {
        if (state is TextScannerPrefixLoadedState) {
          return CameraView(
            title: 'Text Detector',
            customPaint: _customPaint,
            text: _text,
            onImage: (inputImage) {
              processImage(inputImage, state.prefix);
            },
          );
        }
        return Container();
      },
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
              AutoRouter.of(context).popUntilRoot();
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
