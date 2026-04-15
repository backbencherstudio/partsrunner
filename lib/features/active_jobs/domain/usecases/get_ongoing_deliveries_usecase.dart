import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/active_jobs/domain/repositories/active_jobs_repository.dart';

class GetOngoingDeliveriesUsecase {
  final ActiveJobsRepository _activeJobsRepository;
  GetOngoingDeliveriesUsecase(this._activeJobsRepository);

  Future<List<DeliveryModel>> call() {
    return _activeJobsRepository.getOngoingDeliveries();
  }
}
