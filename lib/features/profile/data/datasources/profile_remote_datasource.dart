import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/core/services/api_service/api_endpoint.dart';

abstract class ProfileRemoteDatasource {
  Future<void> getProfile();
  Future<void> updateProfile();
  Future<Map<String, dynamic>> changePassword(
    String oldPassword,
    String newPassword,
  );
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ApiClient _apiClient;

  ProfileRemoteDatasourceImpl(this._apiClient);

  @override
  Future<void> getProfile() async {
    // final response = await _apiClient.get(ApiEndpoints.me);
  }

  @override
  Future<void> updateProfile() async {
    // final response = await _apiClient.put(ApiEndpoints.updateUser);
  }

  @override
  Future<Map<String, dynamic>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.changePassword,
        body: {"old_password": oldPassword, "new_password": newPassword},
      );
      print(response);
      return response;
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
