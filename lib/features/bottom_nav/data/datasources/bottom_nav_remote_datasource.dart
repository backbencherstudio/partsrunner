import 'package:partsrunner/core/ApiService/ApiClient.dart';
import 'package:partsrunner/core/ApiService/ApiEndPoint.dart';
import 'package:partsrunner/features/bottom_nav/data/models/bottom_nav_model.dart';

abstract class BottomNavRemoteDatasource {
  Future<BottomNavModel> getUser();
}

class BottomNavRemoteDataSourceImpl implements BottomNavRemoteDatasource {
  final ApiClient _apiClient;

  BottomNavRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<BottomNavModel> getUser() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.me);
      print(response['data']);
      if (response['data'] != null) {
        return BottomNavModel.fromJson(response['data']);
      }
      throw Exception('Failed to get user');
    } catch (e) {
      rethrow;
    }
  }
}
