import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/data/datasource/rezervation_number_remote_datasource.dart';
import 'package:ticket_prod_v2/src/rezervation_number_page/repository/rezervation_number_repository.dart';

class RezervationNumberRepositoryImpl implements RezervationNumberRepository {
  final RezervationNumberRemoteDataSource _dataSource =
      GetIt.instance<RezervationNumberRemoteDataSource>();

  @override
  ResultFuture<OrderEntity> getRezervation(String number) async {
    try {
      final result = await _dataSource.getRezervationNumber(number);
      return Right(result);
    } on APIExeption catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }
}
