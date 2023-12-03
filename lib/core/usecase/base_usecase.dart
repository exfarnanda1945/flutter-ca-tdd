import 'package:tdd_flutter/core/utils/typedef.dart';

abstract class BaseUsecase<Error, Result> {
  const BaseUsecase();

  ResultFuture<Error, Result> call();
}
