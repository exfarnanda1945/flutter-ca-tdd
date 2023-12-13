import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/src/auth_feat/domain/usecases/create_user.dart';

import 'auth_repository.mock.dart';

// Unit Test --> Focus on small test or unit
// 3 thing when do unit test
// 1. What does a class depend on? --> CreateUser usecase depends on AuthRepository
// 2. How to create a fake / mock version of dependency? --> Using mocktail
// 3. How to control what our dependencies do? (control the result and only invoke at internal not the real external services like http/db)
// --> Use Mocktail API's

void main() {
  late CreateUser usecase;
  late MockAuthRepository mockAuthRepo;

// Do something before run the test and run again after each test (like initiate late variable)
  setUp(() {
    mockAuthRepo = MockAuthRepository();
    usecase = CreateUser(mockAuthRepo);
  });

  const createUserParams = CreateUserParams.empty();
  test('Should call the [AuthRepository.createUser]', () async {
    // 3 Simple Test

    // Arrange
    // when --> control the auth repo when call create user
    // any --> Find the generic value and named of value
    when(() => mockAuthRepo.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar")))
        // then... --> hijack the result value from mockAuthRepo.createUser when called (stubbing process)
        // thenThrow --> used to force dependency return an error
        // thenAnswer --> used to force dependency return a value if the function is async
        // thenReturn --> used to force dependency return a value if the function is sync/not async
        // because in this test want to return void, we gonna mimic the result to void. The function createUser return Either<BaseError, void> ,
        // so we use Right because type void in the right Either type result
        .thenAnswer((invocation) async => const Right(null));

    //Act
    final result = await usecase(createUserParams);

    //Assert
    // expect result from use case equals to void or Right(null)
    // Using dynamic for left Either because we don't know what type of error and also we wont to import BaseError from main module
    expect(result, equals(const Right<dynamic, void>(null)));

    // Verify the passed argument from createUser must be same value from const createUserParams = CreateUserParams.empty();
    // Called --> verify to call createUser only once / one time.
    verify(() => mockAuthRepo.createUser(
        createdAt: createUserParams.createdAt,
        name: createUserParams.name,
        avatar: createUserParams.avatar)).called(1);

    // Verify there's no interaction with MockAuthRepository
    verifyNoMoreInteractions(mockAuthRepo);
  });
}



