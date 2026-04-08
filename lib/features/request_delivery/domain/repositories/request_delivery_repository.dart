import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';

abstract class RequestDeliveryRepository {
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