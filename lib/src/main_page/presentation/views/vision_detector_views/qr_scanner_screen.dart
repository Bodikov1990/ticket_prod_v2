import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';
import 'package:ticket_prod_v2/src/main_page/presentation/bloc/main_qr_bloc.dart';

import 'detector_view.dart';

@RoutePage()
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final _mainQrBloc = MainQrBloc();
  bool isCodeProcessed = false;

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    debugPrint('disposed');
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy || isCodeProcessed) return;
    _isBusy = true;

    final barcodes = await _barcodeScanner.processImage(inputImage);

    for (final barcode in barcodes) {
      if (barcode.rawValue != null && !isCodeProcessed) {
        GetIt.I<Talker>().debug(barcode.rawValue);
        _mainQrBloc.add(MainQrGetRezervationEvent(id: barcode.rawValue!));
        isCodeProcessed = true;
      }
    }

    _customPaint = null;
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainQrBloc, MainQrState>(
      bloc: _mainQrBloc,
      listener: (context, state) {
        if (state is MainQrGetRezervationErrorState) {
          _showAlert(title: state.message);
        } else if (state is MainQrGetRezervationSuccesState) {
          AutoRouter.of(context).push(DetailsRoute(
              ticket: state.ticket,
              onTapActivate: (isBackTapped) {
                if (isBackTapped) {
                  debugPrint("IS BACK $isBackTapped");
                }
              }));
        }
      },
      builder: (context, state) {
        return DetectorView(
          title: 'Barcode Scanner',
          customPaint: _customPaint,
          text: _text,
          onImage: (inputImage) {
            _processImage(inputImage);
          },
        );
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
