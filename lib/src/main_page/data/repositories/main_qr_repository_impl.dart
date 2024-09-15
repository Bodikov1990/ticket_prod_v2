import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/data/datasource/main_qr_remote_datasource.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/main_page/repository/main_qr_repository.dart';

class MainQRRepositoryImpl implements MainQRRepository {
  final MainQRRemoteDataSource _dataSource =
      GetIt.instance<MainQRRemoteDataSource>();

  @override
  ResultFuture<OrderEntity> getRezervation(String id) async {
    try {
      final result = await _dataSource.getRezervation(id);
      return Right(result);
    } on APIExeption catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }
}
