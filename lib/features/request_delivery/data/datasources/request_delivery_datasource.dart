import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/core/api_service/api_endpoint.dart';
import 'package:partsrunner/features/request_delivery/data/models/supplier_model.dart';

import '../../domain/entities/supplier_entity.dart';

abstract class RequestDeliveryDatasource {
  Future<List<SupplierEntity>> getSuppliers();
  Future<void> createRequestDelivery({
    required String packageName,
    required double weight,
    required String supplierId,
    required String pickupDate,
    required String technicianName,
    required String technicianPhone,
    required String deliveryAddress,
    required String specialInstructions,
    required String paymentProvider,
  });
}

class RequestDeliveryDatasourceImpl implements RequestDeliveryDatasource {
  final ApiClient _apiClient;

  RequestDeliveryDatasourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<SupplierModel>> getSuppliers() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.contractorSuppliers);
      final List<SupplierModel> suppliers =
          SupplierModel.supplierModelListFromJson(response['data']);
      return suppliers;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createRequestDelivery({
    required String packageName,
    required double weight,
    required String supplierId,
    required String pickupDate,
    required String technicianName,
    required String technicianPhone,
    required String deliveryAddress,
    required String specialInstructions,
    required String paymentProvider,
  }) async {
    try {
      await _apiClient.post(
        ApiEndpoints.contractorDeliveries,
        body: {
          'package_name': packageName,
          'weight': weight,
          'supplier_id': supplierId,
          'pickup_date': pickupDate,
          'technician_name': technicianName,
          'technician_phone': technicianPhone,
          'delivery_address': deliveryAddress,
          'special_instructions': specialInstructions,
          'payment_provider': paymentProvider,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
