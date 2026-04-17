import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/my_order/data/models/order_model.dart';

abstract class OrderRepository {
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
