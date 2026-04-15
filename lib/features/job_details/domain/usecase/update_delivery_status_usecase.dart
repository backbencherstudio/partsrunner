import 'package:partsrunner/features/job_details/domain/repositories/job_details_repository.dart';

class UpdateDeliveryStatusUsecase {
  final JobDetailsRepository _jobDetailsRepository;
  UpdateDeliveryStatusUsecase(this._jobDetailsRepository);

  Future<void> call(String id, String status, List<String>? proofFile) {
    return _jobDetailsRepository.updateDeliveryStatus(id, status, proofFile);
  }
}
