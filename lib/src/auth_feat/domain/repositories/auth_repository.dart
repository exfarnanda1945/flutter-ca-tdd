import 'package:tdd_flutter/core/errors/base_error.dart';
import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

// Why use BaseError?
// Because we dont know what a kind type of error (api error, connectivity error, device error, etc)
  ResultFuture<BaseError, void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<BaseError, List<User>> listUser();
}
