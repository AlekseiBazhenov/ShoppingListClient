import 'package:equatable/equatable.dart';

import 'api_error.dart';

class ApiResponse<T extends Equatable> {
  final T? data;
  final ApiError? error;

  ApiResponse({required this.data, required this.error});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) create,
  ) {
    final data = json["data"];
    return ApiResponse<T>(
      data: create(data),
      error: null,
    );
  }

  factory ApiResponse.errorFromJson(Map<String, dynamic> json) {
    final error = json["error"];
    return ApiResponse<T>(
      data: null,
      error: ApiError.fromJson(error),
    );
  }
}
