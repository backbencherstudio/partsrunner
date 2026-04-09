import 'package:partsrunner/features/active_tracking/data/datasources/active_deliveries_remote_datasource.dart';
import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';
import 'package:partsrunner/features/active_tracking/domain/repositories/active_deliveries_repository.dart';

class ActiveDeliveriesRepositoryImpl extends ActiveDeliveriesRepository {
  final ActiveDeliveriesRemoteDatasource _activeDeliveriesRemoteDatasource;

  ActiveDeliveriesRepositoryImpl({
    required ActiveDeliveriesRemoteDatasource activeDeliveriesRemoteDatasource,
  }) : _activeDeliveriesRemoteDatasource = activeDeliveriesRemoteDatasource;
  @override
  Future<List<ActiveDeliveryModel>> getActiveDeliveries() {
    return _activeDeliveriesRemoteDatasource.getActiveDeliveries();
  }
}
