import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String identifier,
    required String otp,
  }) =>
      _repository.verifyOtp(
        identifier: identifier,
        otp: otp,
      );
}
