import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';
import 'package:tdd_flutter/src/auth_feat/domain/usecases/create_user.dart';
import 'package:tdd_flutter/src/auth_feat/domain/usecases/list_user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required CreateUser createUser, required ListUser getListUser})
      : _createUser = createUser,
        _getListUser = getListUser,
        super(const AuthInitialState()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final ListUser _getListUser;

  FutureOr<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(const CreatingUserState());

    final result = await _createUser(CreateUserParams(
        createdAt: event.createdAt, name: event.name, avatar: event.avatar));
  }

  FutureOr<void> _getUsersHandler(
      GetUsersEvent event, Emitter<AuthState> emit) {}
}
