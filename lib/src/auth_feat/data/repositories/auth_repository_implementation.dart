import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/core/errors/base_error.dart';
import 'package:tdd_flutter/core/errors/server_error.dart';
import 'package:tdd_flutter/core/exceptions/server_exception.dart';
import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/data/data_source/remote/auth_remote_data_source.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';
import 'package:tdd_flutter/src/auth_feat/domain/repositories/auth_repository.dart';

// Implement D --> dependency inversion, pass the dependency in the constructor

class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<BaseError, void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerError.fromException(e));
    }
  }

  @override
  ResultFuture<BaseError, List<User>> listUser() async {
    try {
      final result = await _remoteDataSource.listUser();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerError.fromException(e));
    }
  }
}
