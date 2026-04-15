import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/presentation/providers/home_provider.dart'
    as homeRemoteDataSource;
import 'package:partsrunner/features/job_details/data/datasource/job_details_remote_datasource.dart';
import 'package:partsrunner/features/job_details/domain/repositories/job_details_repository.dart';

class JobDetailsRepositoryImpl implements JobDetailsRepository {
  final JobDetailsRemoteDatasource _jobDetailsRemoteDatasource;

  JobDetailsRepositoryImpl(this._jobDetailsRemoteDatasource);

  @override
  Future<DeliveryModel> getRequestById(String id) {
    return _jobDetailsRemoteDatasource.getRequestById(id);
  }

  @override
  Future<void> runnerAcceptRequest(String id) {
    return _jobDetailsRemoteDatasource.runnerAcceptRequest(id);
  }

  @override
  Future<void> runnerRejectRequest(String id) {
    return _jobDetailsRemoteDatasource.runnerRejectRequest(id);
  }
}
