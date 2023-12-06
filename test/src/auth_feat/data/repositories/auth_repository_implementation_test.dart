import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/src/auth_feat/data/data_source/remote/auth_remote_data_source.dart';
import 'package:tdd_flutter/src/auth_feat/data/repositories/auth_repository_implementation.dart';

import 'MockAuthRemoteDataSource.dart';

void main() {
  late AuthRemoteDataSource mockRemote;
  late AuthRepositoryImplementation repoImpl;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    repoImpl = AuthRepositoryImplementation(mockRemote);
  });

  test('should call [AuthRemoteDataSource] and return successful', () async {
    when(() => mockRemote.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: "avatar"))).thenAnswer((invocation) => Future.value());
  });
}
