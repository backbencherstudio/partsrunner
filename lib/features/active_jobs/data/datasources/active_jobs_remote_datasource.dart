import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/core/services/api_service/api_endpoint.dart';

abstract class ActiveJobsRemoteDatasource {
  Future<List<DeliveryModel>> getAllDeliveries();
  Future<List<DeliveryModel>> getOngoingDeliveries();
  Future<List<DeliveryModel>> getCompletedDeliveries();
  Future<List<DeliveryModel>> getCanceledDeliveries();
}

class ActiveJobsRemoteDatasourceImpl implements ActiveJobsRemoteDatasource {
  final ApiClient _apiClient;
  ActiveJobsRemoteDatasourceImpl(this._apiClient);

  @override
  Future<List<DeliveryModel>> getAllDeliveries() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.runnerDeliveries);
      print("r: $response");
      if (!response['success']) {
        throw Exception('Failed: $response');
      }
      return DeliveryModel.fromJsonList(response['data']);
    } catch (e) {
      throw Exception('Failed to fetch: $e');
    }
  }

  @override
  Future<List<DeliveryModel>> getCanceledDeliveries() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.runnerCanceledDeliveries,
      );
      print("r: $response");
      if (!response['success']) {
        throw Exception('Failed: $response');
      }
      return DeliveryModel.fromJsonList(response['data']);
    } catch (e) {
      throw Exception('Failed to fetch: $e');
    }
  }

  @override
  Future<List<DeliveryModel>> getCompletedDeliveries() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.runnerCompletedDeliveries,
      );
      if (!response['success']) {
        throw Exception('Failed: $response');
      }
      return DeliveryModel.fromJsonList(response['data']);
    } catch (e) {
      throw Exception('Failed to fetch: $e');
    }
  }

  @override
  Future<List<DeliveryModel>> getOngoingDeliveries() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.runnerOngoingDeliveries,
      );
      if (!response['success']) {
        throw Exception('Failed: $response');
      }
      return DeliveryModel.fromJsonList(response['data']);
    } catch (e) {
      throw Exception('Failed to fetch: $e');
    }
  }
}
