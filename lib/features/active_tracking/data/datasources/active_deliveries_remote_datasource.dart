import 'package:partsrunner/core/services/api/api_client.dart';
import 'package:partsrunner/core/services/api/api_endpoint.dart';
import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';

abstract class ActiveDeliveriesRemoteDatasource {
  Future<List<ActiveDeliveryModel>> getActiveDeliveries();
}

class ActiveDeliveriesRemoteDatasourceImpl
    implements ActiveDeliveriesRemoteDatasource {
  final ApiClient _apiClient;
  ActiveDeliveriesRemoteDatasourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;
  @override
  Future<List<ActiveDeliveryModel>> getActiveDeliveries() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.contractorActiveTracking,
      );
      return ActiveDeliveryModel.getActiveDeliveriesFromList(response['data']);
    } catch (e) {
      throw Exception('Fetching failed: $e');
    }
  }
}
