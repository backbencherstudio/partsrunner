import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';

class UpdateOrderUsecase {
  final OrderRepository _orderRepository;
  UpdateOrderUsecase(this._orderRepository);

  Future<void> call(
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
    return _orderRepository.updateOrder(
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
