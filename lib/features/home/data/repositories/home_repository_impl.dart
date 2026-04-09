import 'package:partsrunner/features/home/data/datasources/home_remote_datasource.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _homeRemoteDataSource;
  HomeRepositoryImpl({required HomeRemoteDatasource homeRemoteDataSource})
    : _homeRemoteDataSource = homeRemoteDataSource;
    
  @override
  Future<void> changeAvailability(bool isOnline) {
    return _homeRemoteDataSource.changeAvailability(isOnline);
  }
}