import 'package:equatable/equatable.dart';

class SuccessResult extends Equatable {
  final bool success;

  SuccessResult({
    required this.success,
  });

  factory SuccessResult.fromJson(Map<String, dynamic> json) {
    return SuccessResult(
      success: json['success'],
    );
  }

  @override
  List<Object> get props => [success];

  @override
  String toString() {
    return '{ success: $success}';
  }
}
