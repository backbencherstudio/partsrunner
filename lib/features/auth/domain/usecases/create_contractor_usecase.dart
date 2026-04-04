import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class CreateContractorUsecase {
  final AuthRepository _authRepository;

  CreateContractorUsecase(this._authRepository);

  Future<void> call({
    required String userId,
    required String companyName,
    required String businessAddress,
  }) {
    return _authRepository.createContractor(
      userId: userId,
      companyName: companyName,
      businessAddress: businessAddress,
    );
  }
}