import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_view.dart';

class TextDetectorScreen extends StatefulWidget {
  const TextDetectorScreen({super.key});

  @override
  State<TextDetectorScreen> createState() => _TextDetectorScreenState();
}

class _TextDetectorScreenState extends State<TextDetectorScreen> {
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  String? _savedPrefix;
  SharedPreferences? _prefs;
  Set<String> processedReservationNumbers = <String>{};

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _savedPrefix = _prefs?.getString('prefix');
  }

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Text Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
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
          final String reservationNumber = element.text;
          if (reservationNumber.startsWith(_savedPrefix ?? "") &&
              reservationNumber.length >= 8) {
            if (!processedReservationNumbers.contains(reservationNumber)) {
              debugPrint('Вывод текста на консоль: $reservationNumber');
              processedReservationNumbers.add(reservationNumber);
              _getReservation(context, reservationNumber);
            }
          }
        }
      }
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<String> processString(BuildContext context, String inputString) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPrefix = prefs.getString('prefix');
    String outputString = "";
    if (inputString.length >= 8 && savedPrefix != null) {
      String firstTwoDigits = inputString.substring(0, 2);

      if (firstTwoDigits == savedPrefix) {
        outputString = inputString.substring(2);
      }
    }
    return outputString;
  }

  Future<void> _getReservation(
      BuildContext context, String reservationNumber) async {
    String newNumber = await processString(context, reservationNumber);

    // try {
    //   final Ticket? ticket =
    //       await _dioRepository.sendGetNumberRequest(newNumber);

    //   if (ticket != null) {
    //     if (ticket.status != 4) {
    //       Navigator.pushReplacementNamed(context, '/details',
    //           arguments: ticket);
    //     } else {
    //       showErrorDialog(context, 'Ошибка!',
    //           'Билет отправлен на возврат. Спасибо за обращение!');
    //     }
    //   }
    // } catch (error) {
    //   if (error is DioException) {
    //     if (error.response?.statusCode == 404) {
    //       showErrorDialog(context, 'Ошибка',
    //           'Извините, бронь не найдена. Пожалуйста, проверьте введенный номер брони и попробуйте снова.');
    //     }
    //   }
    // }
  }
}
