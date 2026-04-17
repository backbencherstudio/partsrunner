import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/my_order/data/datasources/order_remote_datasource.dart';
import 'package:partsrunner/features/my_order/data/models/order_model.dart';
import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource _orderRemoteDatasource;
  OrderRepositoryImpl(this._orderRemoteDatasource);
  @override
  Future<void> cancelOrder(String id) {
    return _orderRemoteDatasource.cancelOrder(id);
  }

  @override
  Future<List<OrderModel>> getCompletedOrder() {
    return _orderRemoteDatasource.getCompletedOrder();
  }

  @override
  Future<List<OrderModel>> getOngoingOrder() {
    return _orderRemoteDatasource.getOngoingOrder();
  }

  @override
  Future<DeliveryModel> getOrderDetails(String id) {
    return _orderRemoteDatasource.getOrderDetails(id);
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
  ) {
    return _orderRemoteDatasource.updateOrder(
      id,
      packageName,
      weight,
      supplierId,
      pickupDate,
      technicianName,
      technicianPhone,
      deliveryAddress,
      specialInstructions,
      paymentProvider,
    );
  }
}
