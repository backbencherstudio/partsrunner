import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/active_jobs/domain/repositories/active_jobs_repository.dart';

class GetCompletedDeliveriesUsecase {
  final ActiveJobsRepository _activeJobsRepository;
  GetCompletedDeliveriesUsecase(this._activeJobsRepository);

  Future<List<DeliveryModel>> call() {
    return _activeJobsRepository.getCompletedDeliveries();
  }
}
