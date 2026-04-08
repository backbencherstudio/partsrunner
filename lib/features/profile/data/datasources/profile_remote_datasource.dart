import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/core/api_service/api_endpoint.dart';

abstract class ProfileRemoteDatasource {
  Future<void> getProfile();
  Future<void> updateProfile();
  Future<void> changePassword(String oldPassword, String newPassword);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ApiClient _apiClient;

  ProfileRemoteDatasourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<void> getProfile() async {
    final response = await _apiClient.get(ApiEndpoints.me);
  }

  @override
  Future<void> updateProfile() async {
    final response = await _apiClient.put(ApiEndpoints.updateUser);
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final response = await _apiClient.post(
      ApiEndpoints.changePassword,
      body: {"old_password": oldPassword, "new_password": newPassword},
    );
    if (response['success']) {
      return;
    } else {
      throw Exception("Change Password Error");
    }
  }
}
