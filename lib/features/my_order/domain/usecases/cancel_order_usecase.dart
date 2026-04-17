import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';

class CancelOrderUsecase {
  final OrderRepository _orderRepository;
  CancelOrderUsecase(this._orderRepository);
  
  Future<void> call(String id) {
    return _orderRepository.cancelOrder(id);
  }
}
