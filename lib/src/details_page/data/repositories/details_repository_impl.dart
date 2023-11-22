import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_prod_v2/core/errors/exeptions.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';
import 'package:ticket_prod_v2/core/utils/typedef.dart';
import 'package:ticket_prod_v2/src/details_page/data/datasource/details_remote_datasource.dart';
import 'package:ticket_prod_v2/src/details_page/domain/entities/activate_entity.dart';
import 'package:ticket_prod_v2/src/details_page/repository/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteDataSource _dataSource =
      GetIt.instance<DetailsRemoteDataSource>();

  @override
  ResultVoid activate(
      {required String ticketID,
      required ActivateEntity activateEntity}) async {
    try {
      await _dataSource.activate(
          ticketID: ticketID, activateEntity: activateEntity);
      return const Right(null);
    } on APIExeption catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }
}
