import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    String? email,
    String? phone,
    String? countryCode,
    String? otp,
    required String newPassword,
  }) =>
      _repository.resetPassword(
        email: email,
        phone: phone,
        countryCode: countryCode,
        otp: otp,
        newPassword: newPassword,
      );
}
