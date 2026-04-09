import 'package:flutter/material.dart';
import 'package:partsrunner/features/request_delivery/domain/repositories/request_delivery_repository.dart';

class CreateRequestDelivery {
  final RequestDeliveryRepository _repository;
  
  CreateRequestDelivery(this._repository);
  
  Future<void> call({
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
  }) {
    return _repository.createRequestDelivery(
      context: context,
      packageName: packageName,
      weight: weight,
      supplierId: supplierId,
      pickupDate: pickupDate,
      technicianName: technicianName,
      technicianPhone: technicianPhone,
      deliveryAddress: deliveryAddress,
      specialInstructions: specialInstructions,
      paymentProvider: paymentProvider,
    );
  }
}
