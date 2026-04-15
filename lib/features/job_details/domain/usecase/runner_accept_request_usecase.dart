import 'package:partsrunner/features/job_details/domain/repositories/job_details_repository.dart';

class RunnerAcceptRequestUsecase {
  final JobDetailsRepository _jobDetailsRepository;
  RunnerAcceptRequestUsecase(this._jobDetailsRepository);

  Future<void> call(String id) {
    return _jobDetailsRepository.runnerAcceptRequest(id);
  }
}
