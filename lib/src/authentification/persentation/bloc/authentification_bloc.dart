import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/create_user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/get_users.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createdUser = createUser,
        _getUsers = getUsers,
        super(const AuthentificationInitial()) {
    on<AuthentificationEvent>((event, emit) {
      on<CreateUserEvent>(_createUserHandler);
      on<GetUserEvent>(_getUsersHandler);
    });
  }

  final CreateUser _createdUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthentificationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createdUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
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

  Future<void> _getUsersHandler(
    GetUserEvent event,
    Emitter<AuthentificationState> emit,
  ) async {
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
