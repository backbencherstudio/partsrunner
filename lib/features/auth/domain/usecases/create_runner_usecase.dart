import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class CreateRunnerUsecase {
  final AuthRepository _authRepository;

  CreateRunnerUsecase(this._authRepository);

  Future<void> call({
    required String userId,
    required String vehicleType,
    required String vehicleModel,
    required String vehicleIdentificationNumber,
  }) {
    return _authRepository.createRunner(
      userId: userId,
      vehicleType: vehicleType,
      vehicleModel: vehicleModel,
      vehicleIdentificationNumber: vehicleIdentificationNumber,
    );
  }
}
