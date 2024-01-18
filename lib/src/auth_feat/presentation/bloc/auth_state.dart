part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

// loading when creating user
class CreatingUserState extends AuthState {
  const CreatingUserState();
}

// loading when getting user
class GettingUserState extends AuthState {
  const GettingUserState();
}

class UserCreatedState extends AuthState {
  const UserCreatedState();
}

class UserLoadedState extends AuthState {
  const UserLoadedState(this.users);

  final List<User> users;

  // The equatable will equating the list by id, cuz equating all list hard in dart
  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthErrorState extends AuthState {
  const AuthErrorState(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
