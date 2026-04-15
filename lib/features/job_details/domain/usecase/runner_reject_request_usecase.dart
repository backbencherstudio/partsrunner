import 'package:partsrunner/features/job_details/domain/repositories/job_details_repository.dart';

class RunnerRejectRequestUsecase {
  final JobDetailsRepository _jobDetailsRepository;
  RunnerRejectRequestUsecase(this._jobDetailsRepository);
  Future<void> call(String id) {
    return _jobDetailsRepository.runnerRejectRequest(id);
  }
}
