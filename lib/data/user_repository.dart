import 'dart:async';

import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/user.dart';

import 'api_client.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<ApiResponse<User>> login(
    String login,
    String password,
  ) async {
    return await apiClient.login(login, password);
  }

  Future<ApiResponse<User>> registration(
    String login,
    String password,
    String passwordConfirmation,
  ) async {
    return await apiClient.registration(login, password, passwordConfirmation);
  }
}
