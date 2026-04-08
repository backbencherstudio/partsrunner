import 'package:geolocator/geolocator.dart';
import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/core/api_service/api_endpoint.dart';

abstract class HomeRemoteDatasource {
  /// for runner
  Future<void> changeAvailability(bool isOnline);
  Future<void> getDeliveryRunner();

  /// for contractor
  Future<void> getDeliveryContractor();
  Future<void> getNewRequests();
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final ApiClient _apiClient;

  HomeRemoteDatasourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<void> changeAvailability(bool isOnline) async {
    print('changeAvailability: $isOnline');
    if (isOnline) {
      await Geolocator.requestPermission();
      Position pos = await Geolocator.getCurrentPosition();
      print('Position: ${pos.latitude}, ${pos.longitude}');
      final response = await _apiClient.post(
        ApiEndpoints.runnerGoOffline,
        body: {"lat": pos.latitude, "lng": pos.longitude},
      );
      if (response['success']) {
        return;
      } else {
        throw Exception(response['message']);
      }
    } else {
      final response = await _apiClient.post(ApiEndpoints.runnerGoOnline);
      if (response['success']) {
        return;
      } else {
        throw Exception(response['message']);
      }
    }
  }

  @override
  Future<void> getDeliveryRunner() async {
    final response = await _apiClient.get(ApiEndpoints.runnerDeliveryHome);
  }

  @override
  Future<void> getDeliveryContractor() async {
    final response = await _apiClient.get(
      ApiEndpoints.contractorDeliveriesHome,
    );
  }
  
  @override
  Future<void> getNewRequests() {
    // TODO: implement getNewRequests
    throw UnimplementedError();
  }
}
