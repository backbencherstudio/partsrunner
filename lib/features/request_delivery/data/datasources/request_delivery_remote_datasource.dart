import 'package:flutter/material.dart';
import 'package:partsrunner/core/services/api/api_client.dart';
import 'package:partsrunner/core/services/api/api_endpoint.dart';
import 'package:partsrunner/core/services/payment/stripe_service.dart';
import 'package:partsrunner/features/request_delivery/data/models/supplier_model.dart';

import '../../domain/entities/supplier_entity.dart';

abstract class RequestDeliveryRemoteDatasource {
  Future<List<SupplierEntity>> getSuppliers();
  Future<void> createRequestDelivery({
    required BuildContext context,
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

class RequestDeliveryRemoteDatasourceImpl
    implements RequestDeliveryRemoteDatasource {
  final ApiClient _apiClient;

  RequestDeliveryRemoteDatasourceImpl({required ApiClient apiClient})
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
    required BuildContext context,
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
      final response = await _apiClient.post(
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
      print(response['data']);
      if (!context.mounted) {
        throw Exception("Widget is no longer mounted. Process cancelled.");
      }
      bool isSuccess = false;
      if (paymentProvider == 'stripe') {
        final clientSecret = response['data']['client_secret'];
        isSuccess = await StripeService.instance.processPayment(
          context: context,
          clientSecret: clientSecret,
        );
      }
      if (paymentProvider == 'paypal') {
        // isSuccess = await PaypalService.instance.processPayment(
        //   context: context,
        //   clientSecret: clientSecret,
        // );
      }

      if (isSuccess) {
        return print("Payment Success");
      }
      throw Exception("Payment Failed");
    } catch (e) {
      throw Exception("Payment Failed: $e");
    }
  }
}
