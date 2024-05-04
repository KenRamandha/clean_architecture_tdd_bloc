part of 'authentification_cubit.dart';

sealed class AuthentificationState extends Equatable {
  const AuthentificationState();
  
  @override
  List<Object> get props => [];
}

final class AuthentificationInitial extends AuthentificationState {
  const AuthentificationInitial();

}

class CreatingUser extends AuthentificationState {
  const CreatingUser();
}

class GettingUsers extends AuthentificationState {
  const GettingUsers();
}

class UserCreated extends AuthentificationState {
  const UserCreated();
}

class UserLoaded extends AuthentificationState {
  const UserLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthentificationError extends AuthentificationState {
  const AuthentificationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}