import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/core/services/api_service/api_endpoint.dart';
import 'package:partsrunner/features/bottom_nav/data/models/user_model.dart';

abstract class BottomNavRemoteDatasource {
  Future<UserModel> getUser();
}

class BottomNavRemoteDataSourceImpl implements BottomNavRemoteDatasource {
  final ApiClient _apiClient;

  BottomNavRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<UserModel> getUser() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.me);
      print(response);
      if (response['data'] != null) {
        return UserModel.fromJson(response['data']);
      }
      throw Exception('Failed to get user');
    } catch (e) {
      rethrow;
    }
  }
}
