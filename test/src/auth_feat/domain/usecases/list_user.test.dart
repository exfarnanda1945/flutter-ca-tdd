import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';
import 'package:tdd_flutter/src/auth_feat/domain/usecases/list_user.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepo;
  late ListUser usecase;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    usecase = ListUser(mockAuthRepo);
  });

  const mockResponse = [User.empty()];

  test('Should call [AuthRepository.listUser] and return [List<User>]',
      () async {
    when(() => mockAuthRepo.listUser())
        .thenAnswer((invocation) async => const Right(mockResponse));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, List<User>>(mockResponse)));
    verify(() => mockAuthRepo.listUser()).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });
}
