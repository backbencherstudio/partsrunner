import 'package:partsrunner/features/home/data/datasources/home_remote_datasource.dart';
import 'package:partsrunner/features/home/data/models/delivery_home_runner_model.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _homeRemoteDataSource;
  HomeRepositoryImpl({required HomeRemoteDatasource homeRemoteDataSource})
    : _homeRemoteDataSource = homeRemoteDataSource;

  @override
  Future<void> changeAvailability(bool isOnline) {
    return _homeRemoteDataSource.changeAvailability(isOnline);
  }

  @override
  Future<ShippingSummaryModel> getDeliveryContractor() {
    return _homeRemoteDataSource.getDeliveryContractor();
  }

  @override
  Future<List<DeliveryModel>> getNewRequest() {
    return _homeRemoteDataSource.getNewRequest();
  }

  @override
  Future<DeliveryHomeRunnerModel> getDeliveryRunner() {
    return _homeRemoteDataSource.getDeliveryRunner();
  }
}
