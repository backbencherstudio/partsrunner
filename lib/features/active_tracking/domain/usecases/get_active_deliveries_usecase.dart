import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';
import 'package:partsrunner/features/active_tracking/domain/repositories/active_deliveries_repository.dart';

class GetActiveDeliveriesUsecase {
  final ActiveDeliveriesRepository _activeDeliveryRepository;
  GetActiveDeliveriesUsecase({
    required ActiveDeliveriesRepository activeDeliveryRepository,
  }) : _activeDeliveryRepository = activeDeliveryRepository;

  Future<List<ActiveDeliveryModel>> call() {
    return _activeDeliveryRepository.getActiveDeliveries();
  }
}
