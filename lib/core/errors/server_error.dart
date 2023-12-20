import 'package:tdd_flutter/core/errors/base_error.dart';
import 'package:tdd_flutter/core/exceptions/server_exception.dart';

class ServerError extends BaseError {
  const ServerError({required super.message, required super.statusCode});

  factory ServerError.fromException(ServerException exception) =>
      ServerError(message: exception.message, statusCode: exception.statusCode);
}
