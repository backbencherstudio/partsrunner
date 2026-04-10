import 'package:partsrunner/features/my_order/data/datasources/order_remote_datasource.dart';
import 'package:partsrunner/features/my_order/data/models/order_model.dart';
import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource _orderRemoteDatasource;
  OrderRepositoryImpl({required OrderRemoteDatasource orderRemoteDatasource})
    : _orderRemoteDatasource = orderRemoteDatasource;

  @override
  Future<List<OrderModel>> getCompleteOrder() {
    return _orderRemoteDatasource.getCompletedOrder();
  }

  @override
  Future<List<OrderModel>> getOngoingOrder() {
    return _orderRemoteDatasource.getOngingOrder();
  }
}
