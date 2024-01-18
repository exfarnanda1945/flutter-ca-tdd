import 'package:tdd_flutter/core/utils/typedef.dart';

abstract class BaseUseCase<Error, Result> {
  const BaseUseCase();

  ResultFuture<Error, Result> call();
}
