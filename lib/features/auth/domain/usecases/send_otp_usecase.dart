import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class SendOtpUseCase {
  const SendOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String identifier}) =>
      _repository.sendOtp(identifier: identifier);
}
