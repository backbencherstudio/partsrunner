import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/core/services/api_service/api_endpoint.dart';

abstract class JobDetailsRemoteDatasource {
  Future<DeliveryModel> getRequestById(String id);
  Future<void> runnerAcceptRequest(String id);
  Future<void> runnerRejectRequest(String id);
}

class JobDetailsRemoteDatasourceImpl implements JobDetailsRemoteDatasource {
  final ApiClient _apiClient;

  JobDetailsRemoteDatasourceImpl(this._apiClient);

  @override
  Future<DeliveryModel> getRequestById(String id) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.runnerDeliveryById(id),
      );
      print(response);
      if (!response['success']) {
        throw Exception(response['message']);
      }
      return DeliveryModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Request accept failed: $e');
    }
  }

  @override
  Future<void> runnerAcceptRequest(String id) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.runnerAcceptOffer,
        body: {"delivery_id": id},
      );
      print(response);
      if (!response['success']) {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Request accept failed: $e');
    }
  }

  @override
  Future<void> runnerRejectRequest(String id) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.runnerRejectOffer,
        body: {"delivery_id": id},
      );
      print(response);
      if (!response['success']) {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Request accept failed: $e');
    }
  }
}
