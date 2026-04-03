import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String identifier,
    required String newPassword,
  }) =>
      _repository.resetPassword(
        identifier: identifier,
        newPassword: newPassword,
      );
}
