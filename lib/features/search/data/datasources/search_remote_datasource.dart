import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/services/api/api_client.dart';
import 'package:partsrunner/core/services/api/api_endpoint.dart';

abstract class SearchRemoteDatasource {
  Future<List<DeliveryModel>> search(String query, bool isContractor);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  final ApiClient _apiClient;
  SearchRemoteDatasourceImpl(this._apiClient);

  @override
  Future<List<DeliveryModel>> search(String query, bool isContractor) async {
    // try {
      final response = await _apiClient.get(
        isContractor ? ApiEndpoints.contractorDeliveries : ApiEndpoints.runnerDeliveries,
        queryParameters: {
          'q': query,
        },
      );
      return DeliveryModel.fromJsonList(response['data']);
    // } catch (e) {
    //   throw Exception("Failed to search. $e");
    // }
  }
}
