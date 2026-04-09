import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';
import 'package:partsrunner/features/request_delivery/domain/repositories/request_delivery_repository.dart';

class GetSuppliers {
  final RequestDeliveryRepository _repository;
  
  GetSuppliers(this._repository);
  
  Future<List<SupplierEntity>> call() {
    return _repository.getSuppliers();
  }
}