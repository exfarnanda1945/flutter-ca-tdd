import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/src/auth_feat/data/data_source/remote/auth_remote_data_source.dart';
import 'package:tdd_flutter/src/auth_feat/data/repositories/auth_repository_implementation.dart';

import 'mock_auth_remote_data_source.dart';

void main() {
  late AuthRemoteDataSource mockRemote;
  late AuthRepositoryImplementation repoImpl;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    repoImpl = AuthRepositoryImplementation(mockRemote);
  });

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

    const createdAt = "test123";
    const name = "name";
    const avatar = "avatar";

    final result = await repoImpl.createUser(
        createdAt: createdAt, name: name, avatar: avatar);

    expect(result, equals(const Right(null)));

    // verify when mockRemote.createUser called (from repoImpl) has same argument
    verify(() => mockRemote.createUser(
        createdAt: createdAt, name: name, avatar: avatar)).called(1);
    verifyNoMoreInteractions(mockRemote);
  });
}
