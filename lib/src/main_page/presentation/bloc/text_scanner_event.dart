part of 'text_scanner_bloc.dart';

abstract class TextScannerEvent extends Equatable {
  const TextScannerEvent();

  @override
  List<Object> get props => [];
}

class TextScannerGetPrefixEvent extends TextScannerEvent {}

class TextScannerGetNumberEvent extends TextScannerEvent {
  final String number;
  const TextScannerGetNumberEvent({
    required this.number,
  });

  @override
  List<Object> get props => [number];
}
