import 'package:clean_rchitecture_tdd_bloc/core/utils/typedef.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';

abstract class AuthentificationRepository {
  const AuthentificationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUser();
}
