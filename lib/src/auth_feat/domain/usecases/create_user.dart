import 'package:equatable/equatable.dart';
import 'package:tdd_flutter/core/errors/base_error.dart';
import 'package:tdd_flutter/core/usecase/base_usecase_with_params.dart';
import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/domain/repositories/auth_repository.dart';

class CreateUser
    extends BaseUsecaseWithParams<BaseError, void, CreateUserParams> {
  const CreateUser(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<BaseError, void> call(CreateUserParams params) async =>
      await _authRepository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  // Empty constructor for test
  const CreateUserParams.empty()
      : this(
            createdAt: "_empty.createdAt",
            name: "_empty.name",
            avatar: "_empty.avatar");

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
