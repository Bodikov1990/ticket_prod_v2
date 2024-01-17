import 'package:equatable/equatable.dart';

class SeanceInfoModel extends Equatable {
  final String id;
  final String movie;
  final DateTime startTime;
  final DateTime endTime;
  final String hallName;
  final int seanceStatus;
  final bool isExistBuy;

  const SeanceInfoModel({
    required this.id,
    required this.movie,
    required this.startTime,
    required this.endTime,
    required this.hallName,
    required this.seanceStatus,
    required this.isExistBuy,
  });

  @override
  List<Object?> get props =>
      [id, movie, startTime, endTime, hallName, seanceStatus, isExistBuy];
}
