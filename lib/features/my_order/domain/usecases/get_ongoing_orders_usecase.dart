import 'package:partsrunner/features/my_order/data/models/order_model.dart';
import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';

class GetOngoingOrdersUsecase {
  final OrderRepository _orderRepository;
  GetOngoingOrdersUsecase(this._orderRepository);

  Future<List<OrderModel>> call() {
    return _orderRepository.getOngoingOrder();
  }
}
