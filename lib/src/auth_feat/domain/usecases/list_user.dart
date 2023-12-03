import 'package:tdd_flutter/core/errors/base_error.dart';
import 'package:tdd_flutter/core/usecase/base_usecase.dart';
import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';
import 'package:tdd_flutter/src/auth_feat/domain/repositories/auth_repository.dart';

class ListUser extends BaseUsecase<BaseError, List<User>> {
  const ListUser(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<BaseError, List<User>> call() async =>
      await _authRepository.listUser();
}
