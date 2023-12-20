import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const BaseException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
