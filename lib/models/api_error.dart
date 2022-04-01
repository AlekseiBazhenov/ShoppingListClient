import 'package:equatable/equatable.dart';

class ApiError extends Equatable {
  final String message;
  final String details;

  ApiError({required this.message, required this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'],
      details: json['details'],
    );
  }

  @override
  List<Object> get props => [message, details];

  @override
  String toString() {
    return '{ id: $message, name: $details }';
  }
}