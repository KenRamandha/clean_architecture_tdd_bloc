import 'package:dartz/dartz.dart';
import 'package:clean_rchitecture_tdd_bloc/core/errors/exception.dart';
import 'package:clean_rchitecture_tdd_bloc/core/errors/failure.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/datasources/authentification_remote_data_source.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/repositories/authentification_repository_implementation.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthentificationRemoteDataSource {}

void main() {
  late AuthentificationRemoteDataSource remoteDataSource;
  late AuthentificationRepositoryImplementation repositoryImplementation;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImplementation =
        AuthentificationRepositoryImplementation(remoteDataSource);
  });

  const tException =
      APIException(message: 'Unkonwn Error Occured', statusCode: 500);

  group('createUser :', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
        'should call [RemoteDataSource.createUser] and complete successfully when the call to the remote source successfull',
        () async {
      //arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((invocation) async => Future.value());

      //act
      final result = await repositoryImplementation.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      //assert
      expect(
        result,
        equals(
          const Right(null),
        ),
      );
      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [APIFailure] when the class to remote source is unseuccessfull',
        () async {
      //Arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);

      final result = await repositoryImplementation.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
        result,
        equals(
          Left(
            APIFailure(
                message: tException.message, statusCode: tException.statusCode),
          ),
        ),
      );

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers :', () {
    test(
        'should call [RemoteDataSource.getUser] and return [List<User>] when call to remote source is susscessfull',
        () async {
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );

      final result = await repositoryImplementation.getUser();
      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [APIFailure] when the class to remote source is unseuccessfull',
        () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repositoryImplementation.getUser();

      expect(result, equals(Left(APIFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
