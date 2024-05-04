import 'package:clean_rchitecture_tdd_bloc/core/usecase/usecase.dart';
import 'package:clean_rchitecture_tdd_bloc/core/utils/typedef.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/repositories/authentification_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthentificationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUser();
}
