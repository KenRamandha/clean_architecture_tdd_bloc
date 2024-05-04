import 'package:dartz/dartz.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/repositories/authentification_repository.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentification_repositor.mock.dart';

void main() {
  late AuthentificationRepository repository;
  late GetUsers useCase;

  setUp(() {
    repository = MockAuthRepo();
    useCase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
    'should call [AuthRepo.getuser] and return [List<User>]',
    () async {
      when(() => repository.getUser()).thenAnswer(
        (invocation) async => const Right(tResponse),
      );

      final result = await useCase();

      expect(
        result,
        equals(
          const Right<dynamic, List<User>>(tResponse),
        ),
      );

      verify(() => repository.getUser()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
