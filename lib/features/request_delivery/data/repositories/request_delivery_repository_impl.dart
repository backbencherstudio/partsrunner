import 'package:partsrunner/features/request_delivery/data/datasources/request_delivery_remote_datasource.dart';
import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';
import 'package:partsrunner/features/request_delivery/domain/repositories/request_delivery_repository.dart';

class RequestDeliveryRepositoryImpl extends RequestDeliveryRepository {
  final RequestDeliveryRemoteDatasource _datasource;
  
  RequestDeliveryRepositoryImpl(this._datasource);
  
  @override
  Future<List<SupplierEntity>> getSuppliers() {
    return _datasource.getSuppliers();
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
  }) {
    return _datasource.createRequestDelivery(
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