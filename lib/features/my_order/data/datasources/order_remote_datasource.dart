import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/services/api/api_client.dart';
import 'package:partsrunner/core/services/api/api_endpoint.dart';
import 'package:partsrunner/features/my_order/data/models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<List<OrderModel>> getOngoingOrder();
  Future<List<OrderModel>> getCompletedOrder();
  Future<DeliveryModel> getOrderDetails(String id);
  Future<void> updateOrder(
    String id,
    String packageName,
    double weight,
    String supplierId,
    String pickupDate,
    String technicianName,
    String technicianPhone,
    String deliveryAddress,
    String specialInstructions,
    String paymentProvider,
  );
  Future<void> cancelOrder(String id);
}

class OrderRemoteDatasourceImpl implements OrderRemoteDatasource {
  final ApiClient _apiClient;
  OrderRemoteDatasourceImpl(this._apiClient);

  @override
  Future<List<OrderModel>> getOngoingOrder() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.contractorDeliveriesOngoing,
      );
      return OrderModel.getOrdersFromList(response['data']);
    } catch (e) {
      throw Exception("Failed to get ongoing orders. $e");
    }
  }

  @override
  Future<List<OrderModel>> getCompletedOrder() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.contractorDeliveriesCompleted,
      );
      return OrderModel.getOrdersFromList(response['data']);
    } catch (e) {
      throw Exception("Failed to get completed orders. $e");
    }
  }

  @override
  Future<DeliveryModel> getOrderDetails(String id) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.contractorDeliveryById(id),
      );
      if (response['success']) {
        return DeliveryModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to get order details');
      }
    } catch (e) {
      throw Exception('Failed to get order details. $e');
    }
  }

  @override
  Future<void> updateOrder(
    String id,
    String packageName,
    double weight,
    String supplierId,
    String pickupDate,
    String technicianName,
    String technicianPhone,
    String deliveryAddress,
    String specialInstructions,
    String paymentProvider,
  ) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoints.contractorDeliveryById(id),
        body: {
          "package_name": packageName,
          "weight": weight,
          "supplier_id": supplierId,
          "pickup_date": pickupDate,
          "technician_name": technicianName,
          "technician_phone": technicianPhone,
          "delivery_address": deliveryAddress,
          "special_instructions": specialInstructions,
          "payment_provider": paymentProvider,
        },
      );
      if (response['success']) {
        return;
      } else {
        throw Exception('Failed to update order');
      }
    } catch (e) {
      throw Exception('Failed to update order. $e');
    }
  }

  @override
  Future<void> cancelOrder(String id) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.contractorDeliveryById(id),
      );
      if (response['success']) {
        return;
      } else {
        throw Exception('Failed to cancel order');
      }
    } catch (e) {
      throw Exception('Failed to cancel order. $e');
    }
  }
}
