import 'package:dartz/dartz.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/repositories/authentification_repository.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentification_repositor.mock.dart';

void main() {
  late CreateUser useCase;
  late AuthentificationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
    'test mocktail [AutheRepo.CreateUser]',
    () async {
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((invocation) async => const Right(null));

      final result = await useCase(params);

      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );

      verify(
        () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
