import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/create_user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/get_users.dart';

part 'authentification_state.dart';

class AuthentificationCubit extends Cubit<AuthentificationState> {
  AuthentificationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createdUser = createUser,
        _getUsers = getUsers,
        super(const AuthentificationInitial());

  final CreateUser _createdUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createdUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    result.fold(
      (failure) => emit(
        AuthentificationError(failure.errorMessage),
      ),
      (_) => emit(
        const UserCreated(),
      ),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
      (failure) => emit(
        AuthentificationError(failure.errorMessage),
      ),
      (users) => emit(
        UserLoaded(users),
      ),
    );
  }
}
