import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  const SignupUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String role,
  }) =>
      _repository.signup(
        name: name,
        email: email,
        countryCode: countryCode,
        phone: phone,
        password: password,
        role: role,
      );
}
