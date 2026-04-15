import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/job_details/domain/repositories/job_details_repository.dart';

class GetRequestByIdUsecase {
  final JobDetailsRepository _jobDetailsRepository;
  GetRequestByIdUsecase(this._jobDetailsRepository);

  Future<DeliveryModel> call(String id) {
    return _jobDetailsRepository.getRequestById(id);
  }
}
