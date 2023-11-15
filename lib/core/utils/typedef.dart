import 'package:dartz/dartz.dart';
import 'package:ticket_prod_v2/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;
