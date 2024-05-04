import 'package:dartz/dartz.dart';
import 'package:clean_rchitecture_tdd_bloc/core/errors/exception.dart';
import 'package:clean_rchitecture_tdd_bloc/core/errors/failure.dart';
import 'package:clean_rchitecture_tdd_bloc/core/utils/typedef.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/datasources/authentification_remote_data_source.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/repositories/authentification_repository.dart';

class AuthentificationRepositoryImplementation
    implements AuthentificationRepository {
  const AuthentificationRepositoryImplementation(this._remoteDataSource);

  final AuthentificationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // Test Driven Development (TDD)
    // Call the remote data source
    // Check if the method returns proper data
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
