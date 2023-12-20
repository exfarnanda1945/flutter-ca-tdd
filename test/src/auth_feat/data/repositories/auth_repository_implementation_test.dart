import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/core/errors/server_error.dart';
import 'package:tdd_flutter/core/exceptions/server_exception.dart';
import 'package:tdd_flutter/src/auth_feat/data/data_source/remote/auth_remote_data_source.dart';
import 'package:tdd_flutter/src/auth_feat/data/models/user_model.dart';
import 'package:tdd_flutter/src/auth_feat/data/repositories/auth_repository_implementation.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';

import 'mock_auth_remote_data_source.dart';

void main() {
  late AuthRemoteDataSource mockRemote;
  late AuthRepositoryImplementation repoImpl;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    repoImpl = AuthRepositoryImplementation(mockRemote);
  });

  group("Create User", () {
    // initial value
    const createdAt = "test123";
    const name = "name";
    const avatar = "avatar";

    test('should call [AuthRemoteDataSource] and return successful', () async {
      // when --> control the AuthRemoteDataSource when call create user
      // any --> Find the generic value and named of value
      // named --> named argument which AuthRemoteDataSource.createUser called from AuthRepositoryImplementation.createUser .
      when(() => mockRemote.createUser(
              // make sure passed "createdAt" argument when AuthRemoteDataSource.createUser called in AuthRepositoryImplementation.createUser
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: "avatar")))
          // always return successful
          .thenAnswer((invocation) => Future.value());

      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(result, equals(const Right(null)));

      // verify when mockRemote.createUser called (from repoImpl) has same argument
      verify(() => mockRemote.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test("should call [AuthRemoteDataSource] and return ApiError", () async {
      when(() => mockRemote.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: "avatar"))).thenThrow(const ServerException(
        message: "Unknown error occurred",
        statusCode: 500,
      ));

      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
          result,
          equals(const Left(ServerError(
              message: "Unknown error occurred", statusCode: 500))));
      verify(() => mockRemote.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });

  group("Lists User", () {
    test("Should call [AuthRemoteDataSource] and return Successful List<User>",
        () async {
      when(() => mockRemote.listUser())
          .thenAnswer((invocation) async => [const UserModel.empty()]);

      final result = await repoImpl.listUser();

      // the problem is List difficult to equate
      // expect(result, equals(const Right([User.empty()])));

      // so we expect the result type instead expect the data result
      // we expect the result type is <Right<dynamic, List<User>>>, because we want successful result
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => mockRemote.listUser()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test("Should call [AuthRemoteDataSource] and return Error ApiError",
        () async {
      when(() => mockRemote.listUser()).thenThrow(const ServerException(
        message: "Unknown error occurred",
        statusCode: 500,
      ));

      final result = await repoImpl.listUser();

      expect(
          result,
          equals(const Left(ServerError(
              message: "Unknown error occurred", statusCode: 500))));
      verify(() => mockRemote.listUser()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}
