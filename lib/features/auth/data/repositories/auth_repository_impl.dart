import 'package:partsrunner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<UserEntity> login({
    required String identifier,
    required String password,
  }) =>
      _remoteDataSource.login(identifier: identifier, password: password);

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) =>
      _remoteDataSource.signup(
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );

  @override
  Future<void> sendOtp({required String identifier}) =>
      _remoteDataSource.sendOtp(identifier: identifier);

  @override
  Future<bool> verifyOtp({required String identifier, required String otp}) =>
      _remoteDataSource.verifyOtp(identifier: identifier, otp: otp);

  @override
  Future<void> resetPassword({
    required String identifier,
    required String newPassword,
  }) =>
      _remoteDataSource.resetPassword(
        identifier: identifier,
        newPassword: newPassword,
      );
}
