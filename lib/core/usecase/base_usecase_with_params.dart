import 'package:tdd_flutter/core/utils/typedef.dart';

abstract class BaseUseCaseWithParams<Error, Result, Params> {
  const BaseUseCaseWithParams();

  ResultFuture<Error, Result> call(Params params);
}
