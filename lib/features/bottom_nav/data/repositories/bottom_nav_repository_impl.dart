import 'package:partsrunner/features/bottom_nav/data/datasources/bottom_nav_remote_datasource.dart';
import 'package:partsrunner/features/bottom_nav/data/models/bottom_nav_model.dart';
import 'package:partsrunner/features/bottom_nav/domain/repositories/bottom_nav_repository.dart';

class BottomNavRepositoryImpl implements BottomNavRepository {
  final BottomNavRemoteDatasource _remoteDatasource;

  BottomNavRepositoryImpl({required BottomNavRemoteDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  @override
  Future<BottomNavModel> getUser() {
    return _remoteDatasource.getUser();
  }
}