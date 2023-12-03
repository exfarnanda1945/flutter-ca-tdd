import 'package:dartz/dartz.dart';

// Need 2 types
// Error generic for error result and Result generic for result type (string, object, etc)
typedef ResultFuture<Error, Result> = Future<Either<Error, Result>>;
