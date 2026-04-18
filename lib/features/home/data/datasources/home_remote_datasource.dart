import 'package:geolocator/geolocator.dart';
import 'package:partsrunner/core/services/api/api_client.dart';
import 'package:partsrunner/core/services/api/api_endpoint.dart';
import 'package:partsrunner/core/services/api/token_service.dart';
import 'package:partsrunner/core/services/websocket/websocket_endpoint.dart';
import 'package:partsrunner/core/services/websocket/websocket_service.dart';
import 'package:partsrunner/features/home/data/models/delivery_home_runner_model.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';

abstract class HomeRemoteDatasource {
  /// for runner
  Future<void> changeAvailability(bool isOnline);
  Future<DeliveryHomeRunnerModel> getDeliveryRunner();
  Future<List<DeliveryModel>> getNewRequest();

  /// for contractor
  Future<ShippingSummaryModel> getDeliveryContractor();
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final ApiClient _apiClient;
  final WebsocketService _socket;

  HomeRemoteDatasourceImpl({
    required ApiClient apiClient,
    required WebsocketService socket,
  }) : _apiClient = apiClient,
       _socket = socket;

  @override
  Future<void> changeAvailability(bool isOnline) async {
    print('changeAvailability: $isOnline');
    if (isOnline) {
      await Geolocator.requestPermission();
      Position pos = await Geolocator.getCurrentPosition();
      print('Position: ${pos.latitude}, ${pos.longitude}');
      final response = await _apiClient.post(
        ApiEndpoints.runnerGoOnline,
        body: {"lat": pos.latitude, "lng": pos.longitude},
      );
      if (response['success']) {
        final token = await TokenService.getToken();
        if (token != null) {
          _socket.connect(baseUrl: WebsocketEndpoint.runner, jwtToken: token);
          _socket.sendLocation(pos.latitude, pos.longitude);
          _socket.startLocationUpdates();
        }
        return;
      } else {
        throw Exception(response['message']);
      }
    } else {
      final response = await _apiClient.post(ApiEndpoints.runnerGoOffline);
      if (response['success']) {
        _socket.stopLocationUpdates();
        _socket.dispose();
        return;
      } else {
        throw Exception(response['message']);
      }
    }
  }

  @override
  Future<DeliveryHomeRunnerModel> getDeliveryRunner() async {
    final response = await _apiClient.get(ApiEndpoints.runnerDeliveryHome);
    print('response: $response');
    if (response['success']) {
      return DeliveryHomeRunnerModel.fromJson(response['data']);
    } else {
      throw Exception(response['message']);
    }
  }

  @override
  Future<ShippingSummaryModel> getDeliveryContractor() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.contractorDeliveriesHome,
      );
      if (response['success']) {
        return ShippingSummaryModel.fromJson(response['data']);
      }
      throw Exception('Fetch failed');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<DeliveryModel>> getNewRequest() async {
    // try {
    final response = await _apiClient.get(
      ApiEndpoints.runnerDeliveryNewRequests,
    );
    // if (response['success']) {
    final result = DeliveryModel.fromJsonList(response['data']);
    return result;
    // }
    //   throw Exception('Fetch failed');
    // } catch (e) {
    //   print('Error in getNewRequest: $e');
    //   throw Exception(e);
    // }
  }
}
