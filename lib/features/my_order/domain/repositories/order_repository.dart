import 'package:partsrunner/features/my_order/data/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOngoingOrder();
  Future<List<OrderModel>> getCompleteOrder();
}
