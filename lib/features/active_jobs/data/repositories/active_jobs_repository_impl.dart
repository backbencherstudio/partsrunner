import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/active_jobs/data/datasources/active_jobs_remote_datasource.dart';
import 'package:partsrunner/features/active_jobs/domain/repositories/active_jobs_repository.dart';

class ActiveJobsRepositoryImpl implements ActiveJobsRepository {
  final ActiveJobsRemoteDatasource _activeJobsRemoteDatasource;
  ActiveJobsRepositoryImpl(this._activeJobsRemoteDatasource);
  @override
  Future<List<DeliveryModel>> getAllDeliveries() {
    return _activeJobsRemoteDatasource.getAllDeliveries();
  }

  @override
  Future<List<DeliveryModel>> getCanceledDeliveries() {
    return _activeJobsRemoteDatasource.getCanceledDeliveries();
  }

  @override
  Future<List<DeliveryModel>> getCompletedDeliveries() {
    return _activeJobsRemoteDatasource.getCompletedDeliveries();
  }

  @override
  Future<List<DeliveryModel>> getOngoingDeliveries() {
    return _activeJobsRemoteDatasource.getOngoingDeliveries();
  }
}
