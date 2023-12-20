import 'package:tdd_flutter/core/exceptions/base_exception.dart';

class ServerException extends BaseException {
  const ServerException({required super.message, required super.statusCode});
}
