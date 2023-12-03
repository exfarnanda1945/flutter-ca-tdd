import 'package:tdd_flutter/core/errors/base_error.dart';

class ApiError extends BaseError {
  const ApiError({required super.message, required super.statusCode});
}
