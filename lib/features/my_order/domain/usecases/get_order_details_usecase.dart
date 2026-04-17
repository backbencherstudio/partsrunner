import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';

class GetOrderDetailsUsecase {
  final OrderRepository _orderRepository;
  GetOrderDetailsUsecase(this._orderRepository);
  
  Future<DeliveryModel> call(String id) {
    return _orderRepository.getOrderDetails(id);
  }
}
