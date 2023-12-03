import 'package:tdd_flutter/core/utils/typedef.dart';

abstract class BaseUsecaseWithParams<Error, Result, Params> {
  const BaseUsecaseWithParams();

  ResultFuture<Error, Result> call(Params params);
}
