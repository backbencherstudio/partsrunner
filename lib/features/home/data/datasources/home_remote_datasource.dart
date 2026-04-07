import 'package:geolocator/geolocator.dart';
import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/core/api_service/api_end_point.dart';

abstract class HomeRemoteDatasource {
  Future<void> runnerGoOnline();
  Future<void> runnerGoOffline();
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final ApiClient _apiClient;

  HomeRemoteDatasourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<void> runnerGoOffline() async {
    await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition();
    final response = await _apiClient.post(
      ApiEndpoints.runnerGoOffline,
      body: {"lat": pos.latitude, "lng": pos.longitude},
    );
    if (response['success']) {
      return;
    } else {
      throw Exception(response['message']);
    }
  }

  @override
  Future<void> runnerGoOnline() async {
    final response = await _apiClient.post(ApiEndpoints.runnerGoOnline);
    if (response['success']) {
      return;
    } else {
      throw Exception(response['message']);
    }
  }
}
