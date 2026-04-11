import 'package:partsrunner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:partsrunner/features/auth/data/models/user_model.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<UserModel> getUser() => _remoteDataSource.getUser();

  @override
  Future<void> login({
    required String identifier,
    required String password,
  }) => _remoteDataSource.login(identifier: identifier, password: password);

  @override
  Future<void> signup({
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String role,
  }) => _remoteDataSource.signup(
    name: name,
    email: email,
    countryCode: countryCode,
    phone: phone,
    password: password,
    role: role,
  );

  @override
  Future<void> sendOtp({required String identifier}) =>
      _remoteDataSource.sendOtp(identifier: identifier);

  @override
  Future<void> verifyOtp({
    required String identifier,
    required String otp,
  }) => _remoteDataSource.verifyOtp(identifier: identifier, otp: otp);

  @override
  Future<void> resetPassword({
    String? email,
    String? phone,
    String? countryCode,
    String? otp,
    required String newPassword,
  }) => _remoteDataSource.resetPassword(
    email: email,
    phone: phone,
    countryCode: countryCode,
    otp: otp,
    newPassword: newPassword,
  );

  @override
  Future<void> forgotPassword({
    String? email,
    String? countryCode,
    String? phone,
  }) => _remoteDataSource.forgotPassword(
    email: email,
    countryCode: countryCode,
    phone: phone,
  );

  @override
  Future<void> createContractor({
    required String userId,
    required String companyName,
    required String businessAddress,
  }) => _remoteDataSource.createContractor(
    userId: userId,
    companyName: companyName,
    businessAddress: businessAddress,
  );

  @override
  Future<void> createRunner({
    required String userId,
    required String vehicleType,
    required String vehicleModel,
    required String vehicleIdentificationNumber,
  }) => _remoteDataSource.createRunner(
    userId: userId,
    vehicleType: vehicleType,
    vehicleModel: vehicleModel,
    vehicleIdentificationNumber: vehicleIdentificationNumber,
  );
}
