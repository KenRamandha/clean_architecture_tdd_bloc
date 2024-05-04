import 'package:dartz/dartz.dart';
import 'package:clean_rchitecture_tdd_bloc/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;
