import 'package:equatable/equatable.dart';

// Abstract error for all error hapened
abstract class BaseError extends Equatable {
  const BaseError({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}
