import 'package:partsrunner/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:partsrunner/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _profileRemoteDatasource;
  ProfileRepositoryImpl(this._profileRemoteDatasource);
  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    return _profileRemoteDatasource.changePassword(oldPassword, newPassword);
  }
}
