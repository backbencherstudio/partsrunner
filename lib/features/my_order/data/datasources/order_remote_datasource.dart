import 'package:partsrunner/features/my_order/domain/entities/order_entity.dart';

abstract class OrderRemoteDatasource {
  Future<List<OrderEntity>> getCurrentShipping();
  Future<List<OrderEntity>> getRecentShipping();
  Future<OrderEntity> getOrderDetails(int orderId);
  Future<void> updateOrder(int orderId);
  Future<void> cancelOrder(int orderId);
}

class OrderRemoteDatasourceImpl implements OrderRemoteDatasource {
  @override
  Future<void> cancelOrder(int orderId) {
    // TODO: implement cancelOrder
    throw UnimplementedError();
  }

  @override
  Future<List<OrderEntity>> getCurrentShipping() {
    // TODO: implement getCurrentShipping
    throw UnimplementedError();
  }

  @override
  Future<OrderEntity> getOrderDetails(int orderId) {
    // TODO: implement getOrderDetails
    throw UnimplementedError();
  }

  @override
  Future<List<OrderEntity>> getRecentShipping() {
    // TODO: implement getRecentShipping
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrder(int orderId) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }
}
